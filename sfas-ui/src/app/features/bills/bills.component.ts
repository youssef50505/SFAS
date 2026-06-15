import { Component, inject, signal, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormBuilder, ReactiveFormsModule, Validators } from '@angular/forms';
import { BillService } from '../../core/services/bill.service';
import { VendorService } from '../../core/services/vendor.service';
import { Bill } from '../../core/models/bill.model';
import { Vendor } from '../../core/models/vendor.model';
import { AuthStore } from '../../core/stores/auth.store';
import { PageHeaderComponent } from '../../shared/components/page-header/page-header.component';
import { GsapFadeDirective } from '../../shared/directives/gsap-fade.directive';
import { ToastService } from '../../shared/components/toast/toast.service';
import { ConfirmationService } from '../../shared/components/confirmation-modal/confirmation.service';

@Component({
  selector: 'app-bills',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule, PageHeaderComponent, GsapFadeDirective],
  templateUrl: './bills.component.html',
  styleUrl: './bills.component.css'
})
export class BillsComponent implements OnInit {
  private billService = inject(BillService);
  private vendorService = inject(VendorService);
  private fb = inject(FormBuilder);
  private toast = inject(ToastService);
  private confirmationService = inject(ConfirmationService);
  authStore = inject(AuthStore);

  bills = signal<Bill[]>([]);
  vendors = signal<Vendor[]>([]);
  
  showAddModal = signal(false);
  isSubmitting = signal(false);
  
  billForm = this.fb.group({
    title: ['', [Validators.required, Validators.minLength(3)]],
    vendorId: ['', [Validators.required]],
    amount: [null as number | null, [Validators.required, Validators.min(0.01)]],
    tax: [0, [Validators.required, Validators.min(0)]],
    description: [''],
    date: [new Date().toISOString().split('T')[0], [Validators.required]],
    imagePath: ['']
  });

  ngOnInit() {
    this.loadBills();
    if (this.authStore.isAdmin()) {
      this.loadVendors();
    }
  }

  loadBills() {
    this.billService.getAllBills().subscribe({
      next: (data) => this.bills.set(data),
      error: () => this.toast.error('Failed to load bills')
    });
  }

  loadVendors() {
    this.vendorService.getAllVendors().subscribe({
      next: (data) => this.vendors.set(data),
      error: () => this.toast.error('Failed to load vendors')
    });
  }

  openAddModal() {
    this.billForm.reset({
      tax: 0,
      date: new Date().toISOString().split('T')[0],
      imagePath: ''
    });
    this.showAddModal.set(true);
  }

  closeAddModal() {
    this.showAddModal.set(false);
  }

  onFileSelected(event: Event) {
    const file = (event.target as HTMLInputElement).files?.[0];
    if (file) {
      this.billForm.patchValue({ imagePath: file.name });
    }
  }

  submitBill() {
    if (this.billForm.invalid) {
      this.billForm.markAllAsTouched();
      return;
    }

    this.isSubmitting.set(true);
    const billData = this.billForm.value as Partial<Bill>;

    this.billService.createBill(billData).subscribe({
      next: () => {
        this.toast.success('Bill created successfully');
        this.loadBills();
        this.closeAddModal();
        this.isSubmitting.set(false);
      },
      error: () => {
        this.toast.error('Failed to create bill');
        this.isSubmitting.set(false);
      }
    });
  }

  updateStatus(bill: Bill, status: 'APPROVED' | 'REJECTED') {
    const actionText = status === 'APPROVED' ? 'approve' : 'reject';
    const intent = status === 'APPROVED' ? 'primary' : 'danger';

    this.confirmationService.confirm({
      title: `${status === 'APPROVED' ? 'Approve' : 'Reject'} Bill`,
      message: `Are you sure you want to ${actionText} the bill "${bill.title}" for $${bill.amount}?`,
      confirmText: `Yes, ${actionText}`,
      cancelText: 'Cancel',
      isDanger: status === 'REJECTED'
    }).then(confirmed => {
      if (confirmed) {
        this.billService.updateBillStatus(bill.id, status).subscribe({
          next: () => {
            this.toast.success(`Bill ${status.toLowerCase()} successfully`);
            this.loadBills();
          },
          error: () => this.toast.error(`Failed to ${actionText} bill`)
        });
      }
    });
  }

  // Getters for template
  get f() { return this.billForm.controls; }
}
