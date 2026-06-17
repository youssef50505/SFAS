import { Component, inject, OnInit, signal, DestroyRef } from '@angular/core';
import { takeUntilDestroyed } from '@angular/core/rxjs-interop';
import { FormBuilder, ReactiveFormsModule, Validators } from '@angular/forms';
import { VendorService } from '../../core/services/vendor.service';
import { Vendor } from '../../core/models/vendor.model';
import { AuthStore } from '../../core/stores/auth.store';
import { PageHeaderComponent } from '../../shared/components/page-header/page-header.component';
import { GsapFadeDirective } from '../../shared/directives/gsap-fade.directive';
import { ToastService } from '../../shared/components/toast/toast.service';
import { ConfirmationService } from '../../shared/components/confirmation-modal/confirmation.service';

@Component({
  selector: 'app-vendors',
  standalone: true,
  imports: [ReactiveFormsModule, PageHeaderComponent, GsapFadeDirective],
  templateUrl: './vendors.component.html',
  styleUrl: './vendors.component.css'
})
export class VendorsComponent implements OnInit {
  private vendorService = inject(VendorService);
  private fb = inject(FormBuilder);
  private toast = inject(ToastService);
  private confirmation = inject(ConfirmationService);
  authStore = inject(AuthStore);

  vendors = signal<Vendor[]>([]);
  showAddModal = signal(false);
  isSubmitting = signal(false);
  isEditing = signal(false);
  currentVendorId = signal<string | null>(null);
  isLoading = signal(true);
  private destroyRef = inject(DestroyRef);

  vendorForm = this.fb.group({
    name: ['', [Validators.required, Validators.minLength(3)]],
    contactEmail: ['', [Validators.required, Validators.email]],
    phoneNumber: ['', [Validators.required, Validators.pattern(/^[0-9+\-\s()]+$/)]],
    taxId: ['', [Validators.required]],
    address: ['', [Validators.required]]
  });

  ngOnInit() {
    this.loadVendors();
  }

  loadVendors() {
    this.isLoading.set(true);
    this.vendorService.getAllVendors()
      .pipe(takeUntilDestroyed(this.destroyRef))
      .subscribe({
        next: (data) => {
          this.vendors.set(data);
          this.isLoading.set(false);
        },
        error: (err) => {
          this.toast.error('Failed to load vendors');
          this.isLoading.set(false);
        }
      });
  }

  openAddModal() {
    this.isEditing.set(false);
    this.currentVendorId.set(null);
    this.vendorForm.reset();
    this.showAddModal.set(true);
  }

  openEditModal(vendor: Vendor) {
    this.isEditing.set(true);
    this.currentVendorId.set(vendor.id);
    this.vendorForm.patchValue({
      name: vendor.name,
      contactEmail: vendor.contactEmail,
      phoneNumber: vendor.phoneNumber,
      taxId: vendor.taxId,
      address: vendor.address
    });
    this.showAddModal.set(true);
  }

  closeAddModal() {
    this.showAddModal.set(false);
  }

  submitVendor() {
    if (this.vendorForm.invalid) {
      this.vendorForm.markAllAsTouched();
      return;
    }

    this.isSubmitting.set(true);
    const vendorData = this.vendorForm.value as Partial<Vendor>;

    if (this.isEditing() && this.currentVendorId()) {
      this.vendorService.updateVendor(this.currentVendorId()!, vendorData)
        .pipe(takeUntilDestroyed(this.destroyRef))
        .subscribe({
          next: () => {
            this.toast.success('Vendor updated successfully');
            this.loadVendors();
            this.closeAddModal();
            this.isSubmitting.set(false);
          },
          error: (err) => {
            this.toast.error('Failed to update vendor');
            this.isSubmitting.set(false);
          }
        });
    } else {
      this.vendorService.createVendor(vendorData)
        .pipe(takeUntilDestroyed(this.destroyRef))
        .subscribe({
          next: () => {
            this.toast.success('Vendor added successfully');
            this.loadVendors();
            this.closeAddModal();
            this.isSubmitting.set(false);
          },
          error: (err) => {
            this.toast.error('Failed to add vendor');
            this.isSubmitting.set(false);
          }
        });
    }
  }

  async deleteVendor(id: string) {
    const confirmed = await this.confirmation.confirm({
      title: 'Delete Vendor',
      message: 'Are you sure you want to delete this vendor? This action cannot be undone.',
      confirmText: 'Delete',
      isDanger: true
    });

    if (confirmed) {
      this.vendorService.deleteVendor(id)
        .pipe(takeUntilDestroyed(this.destroyRef))
        .subscribe({
          next: () => {
            this.toast.success('Vendor deleted successfully');
            this.loadVendors();
          },
          error: (err) => {
            this.toast.error('Failed to delete vendor');
          }
        });
    }
  }

  // Getters for form validation
  get f() { return this.vendorForm.controls; }
}
