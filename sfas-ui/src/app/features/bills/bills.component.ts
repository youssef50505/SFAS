import { Component, inject, signal, OnInit, DestroyRef, ChangeDetectionStrategy } from '@angular/core';
import { takeUntilDestroyed } from '@angular/core/rxjs-interop';
import { DatePipe, CurrencyPipe, NgClass } from '@angular/common';
import { FormBuilder, ReactiveFormsModule, Validators } from '@angular/forms';
import { Bill } from '../../core/models/bill.model';
import { AuthStore } from '../../core/stores/auth.store';
import { DocumentStatus } from '../../core/models/status.enum';
import { PageHeaderComponent } from '../../shared/components/page-header/page-header.component';
import { GsapFadeDirective } from '../../shared/directives/gsap-fade.directive';
import { ToastService } from '../../shared/components/toast/toast.service';
import { ConfirmationService } from '../../shared/components/confirmation-modal/confirmation.service';
import { ReviewModalComponent, ReviewModalConfig } from '../../shared/components/review-modal/review-modal.component';
import { EmptyStateComponent } from '../../shared/components/empty-state/empty-state.component';
import { BillStore } from './store/bill.store';

@Component({
  selector: 'app-bills',
  standalone: true,
  imports: [DatePipe, CurrencyPipe, NgClass, ReactiveFormsModule, PageHeaderComponent, GsapFadeDirective, ReviewModalComponent, EmptyStateComponent],
  templateUrl: './bills.component.html',
  styleUrl: './bills.component.css',
  changeDetection: ChangeDetectionStrategy.OnPush
})
export class BillsComponent implements OnInit {
  store = inject(BillStore);
  private fb = inject(FormBuilder);
  private confirmationService = inject(ConfirmationService);
  authStore = inject(AuthStore);
  showAddModal = signal(false);
  DocumentStatus = DocumentStatus;
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
    this.store.loadBills().pipe(takeUntilDestroyed(this.destroyRef)).subscribe();
    if (this.authStore.isAdmin()) {
      this.store.loadVendors().pipe(takeUntilDestroyed(this.destroyRef)).subscribe();
    }
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

    const billData = this.billForm.value as Partial<Bill>;

    this.store.createBill(billData)
      .pipe(takeUntilDestroyed(this.destroyRef))
      .subscribe({
        next: () => {
          this.store.loadBills().pipe(takeUntilDestroyed(this.destroyRef)).subscribe();
          this.closeAddModal();
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
      isReadOnly: bill.status !== DocumentStatus.PENDING || !this.authStore.isFinanceOfficer()
    };
  }

  openReviewModal(bill: Bill) {
    this.selectedBillForReview.set(bill);
  }

  closeReviewModal() {
    this.selectedBillForReview.set(null);
  }

  handleReviewAction(comments: string, status: DocumentStatus) {
    const bill = this.selectedBillForReview();
    if (!bill) return;

    const actionText = status === DocumentStatus.APPROVED ? 'approve' : (status === DocumentStatus.REJECTED ? 'reject' : 'mark pending');

    this.confirmationService.confirm({
      title: `${status === DocumentStatus.APPROVED ? 'Approve' : (status === DocumentStatus.REJECTED ? 'Reject' : 'Pending')} Bill`,
      message: `Are you sure you want to ${actionText} the bill "${bill.title}" for EGP ${bill.amount}?`,
      confirmText: `Yes, ${actionText}`,
      cancelText: 'Cancel',
      isDanger: status === 'REJECTED'
    }).then(confirmed => {
      if (confirmed) {
        this.store.updateBillStatus(bill.id, status, comments)
          .pipe(takeUntilDestroyed(this.destroyRef))
          .subscribe({
            next: () => {
              this.store.loadBills().pipe(takeUntilDestroyed(this.destroyRef)).subscribe();
              this.closeReviewModal();
            }
          });
      }
    });
  }

  // Getters for template
  get f() { return this.billForm.controls; }
}
