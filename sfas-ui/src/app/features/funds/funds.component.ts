import { Component, inject, signal, OnInit, DestroyRef } from '@angular/core';
import { takeUntilDestroyed } from '@angular/core/rxjs-interop';
import { DatePipe, CurrencyPipe, NgClass } from '@angular/common';
import { FormBuilder, ReactiveFormsModule, Validators } from '@angular/forms';
import { Fund } from '../../core/models/fund.model';
import { AuthStore } from '../../core/stores/auth.store';
import { Role } from '../../core/models/role.enum';
import { DocumentStatus, UrgencyLevel } from '../../core/models/status.enum';
import { PageHeaderComponent } from '../../shared/components/page-header/page-header.component';
import { GsapFadeDirective } from '../../shared/directives/gsap-fade.directive';
import { ToastService } from '../../shared/components/toast/toast.service';
import { ConfirmationService } from '../../shared/components/confirmation-modal/confirmation.service';
import { ReviewModalComponent, ReviewModalConfig } from '../../shared/components/review-modal/review-modal.component';
import { EmptyStateComponent } from '../../shared/components/empty-state/empty-state.component';
import { FundStore } from './store/fund.store';

@Component({
  selector: 'app-funds',
  standalone: true,
  imports: [DatePipe, CurrencyPipe, NgClass, ReactiveFormsModule, PageHeaderComponent, GsapFadeDirective, ReviewModalComponent, EmptyStateComponent],
  templateUrl: './funds.component.html',
  styleUrl: './funds.component.css'
})
export class FundsComponent implements OnInit {
  store = inject(FundStore);
  private fb = inject(FormBuilder);
  private confirmationService = inject(ConfirmationService);
  authStore = inject(AuthStore);

  showAddModal = signal(false);
  DocumentStatus = DocumentStatus;
  private destroyRef = inject(DestroyRef);

  fundForm = this.fb.group({
    title: ['', [Validators.required, Validators.minLength(3)]],
    description: ['', [Validators.required, Validators.minLength(10)]],
    amountOfFund: [null as number | null, [Validators.required, Validators.min(0.01)]],
    urgencyLevel: [UrgencyLevel.LOW as string, [Validators.required]],
    date: [new Date().toISOString().split('T')[0], [Validators.required]]
  });

  ngOnInit() {
    this.store.loadFunds().pipe(takeUntilDestroyed(this.destroyRef)).subscribe();
  }

  openAddModal() {
    this.fundForm.reset({
      urgencyLevel: UrgencyLevel.LOW as string,
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

    const fundData = this.fundForm.value as Partial<Fund>;

    this.store.createFund(fundData)
      .pipe(takeUntilDestroyed(this.destroyRef))
      .subscribe({
        next: () => {
          this.store.loadFunds().pipe(takeUntilDestroyed(this.destroyRef)).subscribe();
          this.closeAddModal();
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
        { label: 'Role', value: fund.createdBy?.role === Role.FINANCE_OFFICER ? 'Finance Officer' : (fund.createdBy?.role || 'User') },
        { label: 'Urgency', value: fund.urgencyLevel }
      ],
      description: fund.description,
      documentName: fund.imagePath,
      status: fund.status,
      comments: fund.reviewComments,
      isReadOnly: fund.status !== DocumentStatus.PENDING || !this.authStore.isFinanceOfficer()
    };
  }

  openReviewModal(fund: Fund) {
    this.selectedFundForReview.set(fund);
  }

  closeReviewModal() {
    this.selectedFundForReview.set(null);
  }

  handleReviewAction(comments: string, status: DocumentStatus) {
    const fund = this.selectedFundForReview();
    if (!fund) return;

    const actionText = status === DocumentStatus.APPROVED ? 'approve' : (status === DocumentStatus.REJECTED ? 'reject' : 'mark pending');

    this.confirmationService.confirm({
      title: `${status === DocumentStatus.APPROVED ? 'Approve' : (status === DocumentStatus.REJECTED ? 'Reject' : 'Pending')} Fund Request`,
      message: `Are you sure you want to ${actionText} the fund request "${fund.title}" for EGP ${fund.amountOfFund}?`,
      confirmText: `Yes, ${actionText}`,
      cancelText: 'Cancel',
      isDanger: status === 'REJECTED'
    }).then(confirmed => {
      if (confirmed) {
        this.store.updateFundStatus(fund.id, status, comments)
          .pipe(takeUntilDestroyed(this.destroyRef))
          .subscribe({
            next: () => {
              this.store.loadFunds().pipe(takeUntilDestroyed(this.destroyRef)).subscribe();
              this.closeReviewModal();
            }
          });
      }
    });
  }


  // Getters for form validation
  get f() { return this.fundForm.controls; }
}
