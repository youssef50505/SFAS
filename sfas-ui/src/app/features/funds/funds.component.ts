import { Component, inject, signal, OnInit, DestroyRef } from '@angular/core';
import { takeUntilDestroyed } from '@angular/core/rxjs-interop';
import { DatePipe, CurrencyPipe, NgClass } from '@angular/common';
import { FormBuilder, ReactiveFormsModule, Validators } from '@angular/forms';
import { FundService } from '../../core/services/fund.service';
import { Fund } from '../../core/models/fund.model';
import { AuthStore } from '../../core/stores/auth.store';
import { PageHeaderComponent } from '../../shared/components/page-header/page-header.component';
import { GsapFadeDirective } from '../../shared/directives/gsap-fade.directive';
import { ToastService } from '../../shared/components/toast/toast.service';
import { ConfirmationService } from '../../shared/components/confirmation-modal/confirmation.service';
import { ReviewModalComponent, ReviewModalConfig } from '../../shared/components/review-modal/review-modal.component';
import { EmptyStateComponent } from '../../shared/components/empty-state/empty-state.component';

@Component({
  selector: 'app-funds',
  standalone: true,
  imports: [DatePipe, CurrencyPipe, NgClass, ReactiveFormsModule, PageHeaderComponent, GsapFadeDirective, ReviewModalComponent, EmptyStateComponent],
  templateUrl: './funds.component.html',
  styleUrl: './funds.component.css'
})
export class FundsComponent implements OnInit {
  private fundService = inject(FundService);
  private fb = inject(FormBuilder);
  private toast = inject(ToastService);
  private confirmationService = inject(ConfirmationService);
  authStore = inject(AuthStore);

  funds = signal<Fund[]>([]);
  showAddModal = signal(false);
  isSubmitting = signal(false);
  isLoading = signal(true);
  private destroyRef = inject(DestroyRef);

  fundForm = this.fb.group({
    title: ['', [Validators.required, Validators.minLength(3)]],
    description: ['', [Validators.required, Validators.minLength(10)]],
    amountOfFund: [null as number | null, [Validators.required, Validators.min(0.01)]],
    urgencyLevel: ['LOW', [Validators.required]],
    date: [new Date().toISOString().split('T')[0], [Validators.required]]
  });

  ngOnInit() {
    this.loadFunds();
  }

  loadFunds() {
    this.isLoading.set(true);
    this.fundService.getAllFunds()
      .pipe(takeUntilDestroyed(this.destroyRef))
      .subscribe({
        next: (data) => {
          this.funds.set(data);
          this.isLoading.set(false);
        },
        error: () => {
          this.toast.error('Failed to load fund requests');
          this.isLoading.set(false);
        }
      });
  }

  openAddModal() {
    this.fundForm.reset({
      urgencyLevel: 'LOW',
      date: new Date().toISOString().split('T')[0]
    });
    this.showAddModal.set(true);
  }

  closeAddModal() {
    this.showAddModal.set(false);
  }

  submitFund() {
    if (this.fundForm.invalid) {
      this.fundForm.markAllAsTouched();
      return;
    }

    this.isSubmitting.set(true);
    const fundData = this.fundForm.value as Partial<Fund>;

    this.fundService.createFund(fundData)
      .pipe(takeUntilDestroyed(this.destroyRef))
      .subscribe({
        next: () => {
          this.toast.success('Fund request submitted successfully');
          this.loadFunds();
          this.closeAddModal();
          this.isSubmitting.set(false);
        },
        error: () => {
          this.toast.error('Failed to submit fund request');
          this.isSubmitting.set(false);
        }
      });
  }

  selectedFundForReview = signal<Fund | null>(null);

  getReviewConfig(): ReviewModalConfig | null {
    const fund = this.selectedFundForReview();
    if (!fund) return null;
    
    return {
      type: 'fund',
      id: fund.id.substring(0, 8).toUpperCase(),
      submittedDate: fund.date,
      title: fund.title,
      grossAmount: fund.amountOfFund,
      details: [
        { label: 'Requestor', value: fund.createdBy?.name || 'Unknown' },
        { label: 'Role', value: fund.createdBy?.role === 'FINANCE_OFFICER' ? 'Finance Officer' : (fund.createdBy?.role || 'User') },
        { label: 'Urgency', value: fund.urgencyLevel }
      ],
      description: fund.description,
      documentName: fund.imagePath,
      status: fund.status,
      comments: fund.reviewComments,
      isReadOnly: fund.status !== 'PENDING' || !this.authStore.isFinanceOfficer()
    };
  }

  openReviewModal(fund: Fund) {
    this.selectedFundForReview.set(fund);
  }

  closeReviewModal() {
    this.selectedFundForReview.set(null);
  }

  handleReviewAction(comments: string, status: 'APPROVED' | 'REJECTED' | 'PENDING') {
    const fund = this.selectedFundForReview();
    if (!fund) return;

    const actionText = status === 'APPROVED' ? 'approve' : (status === 'REJECTED' ? 'reject' : 'mark pending');

    this.confirmationService.confirm({
      title: `${status === 'APPROVED' ? 'Approve' : (status === 'REJECTED' ? 'Reject' : 'Pending')} Fund Request`,
      message: `Are you sure you want to ${actionText} the fund request "${fund.title}" for EGP ${fund.amountOfFund}?`,
      confirmText: `Yes, ${actionText}`,
      cancelText: 'Cancel',
      isDanger: status === 'REJECTED'
    }).then(confirmed => {
      if (confirmed) {
        this.fundService.updateFundStatus(fund.id, status, comments)
          .pipe(takeUntilDestroyed(this.destroyRef))
          .subscribe({
            next: () => {
              this.toast.success(`Fund request ${status.toLowerCase()} successfully`);
              this.loadFunds();
              this.closeReviewModal();
            },
            error: () => this.toast.error(`Failed to ${actionText} fund request`)
          });
      }
    });
  }

  // Getters for form validation
  get f() { return this.fundForm.controls; }
}
