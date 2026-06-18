import { Component, inject, signal, OnInit, DestroyRef } from '@angular/core';
import { takeUntilDestroyed } from '@angular/core/rxjs-interop';
import { DatePipe, CurrencyPipe, NgClass } from '@angular/common';
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
import { ReviewModalComponent, ReviewModalConfig } from '../../shared/components/review-modal/review-modal.component';
import { EmptyStateComponent } from '../../shared/components/empty-state/empty-state.component';

@Component({
  selector: 'app-bills',
  standalone: true,
  imports: [DatePipe, CurrencyPipe, NgClass, ReactiveFormsModule, PageHeaderComponent, GsapFadeDirective, ReviewModalComponent, EmptyStateComponent],
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
  isLoading = signal(true);
  private destroyRef = inject(DestroyRef);
  
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
    this.isLoading.set(true);
    this.billService.getAllBills()
      .pipe(takeUntilDestroyed(this.destroyRef))
      .subscribe({
        next: (data) => {
          this.bills.set(data);
          this.isLoading.set(false);
        },
        error: () => {
          this.toast.error('Failed to load bills');
          this.isLoading.set(false);
        }
      });
  }

  loadVendors() {
    this.vendorService.getAllVendors()
      .pipe(takeUntilDestroyed(this.destroyRef))
      .subscribe({
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

    this.billService.createBill(billData)
      .pipe(takeUntilDestroyed(this.destroyRef))
      .subscribe({
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

  selectedBillForReview = signal<Bill | null>(null);

  getReviewConfig(): ReviewModalConfig | null {
    const bill = this.selectedBillForReview();
    if (!bill) return null;
    
    return {
      type: 'bill',
      id: bill.id.substring(0, 8).toUpperCase(),
      submittedDate: bill.date,
      title: bill.title,
      grossAmount: bill.amount,
      details: [
        { label: 'VENDOR', value: bill.vendor.name },
        { label: 'TAX', value: 'EGP ' + (bill.tax || 0).toFixed(2) }
      ],
      description: bill.description,
      documentName: bill.imagePath,
      status: bill.status,
      comments: bill.reviewComments,
      isReadOnly: bill.status !== 'PENDING' || !this.authStore.isFinanceOfficer()
    };
  }

  openReviewModal(bill: Bill) {
    this.selectedBillForReview.set(bill);
  }

  closeReviewModal() {
    this.selectedBillForReview.set(null);
  }

  handleReviewAction(comments: string, status: 'APPROVED' | 'REJECTED' | 'PENDING') {
    const bill = this.selectedBillForReview();
    if (!bill) return;

    const actionText = status === 'APPROVED' ? 'approve' : (status === 'REJECTED' ? 'reject' : 'mark pending');

    this.confirmationService.confirm({
      title: `${status === 'APPROVED' ? 'Approve' : (status === 'REJECTED' ? 'Reject' : 'Pending')} Bill`,
      message: `Are you sure you want to ${actionText} the bill "${bill.title}" for EGP ${bill.amount}?`,
      confirmText: `Yes, ${actionText}`,
      cancelText: 'Cancel',
      isDanger: status === 'REJECTED'
    }).then(confirmed => {
      if (confirmed) {
        this.billService.updateBillStatus(bill.id, status, comments)
          .pipe(takeUntilDestroyed(this.destroyRef))
          .subscribe({
            next: () => {
              this.toast.success(`Bill ${status.toLowerCase()} successfully`);
              this.loadBills();
              this.closeReviewModal();
            },
            error: () => this.toast.error(`Failed to ${actionText} bill`)
          });
      }
    });
  }

  // Getters for template
  get f() { return this.billForm.controls; }
}
