import { Component, inject, signal, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormBuilder, ReactiveFormsModule, Validators } from '@angular/forms';
import { FundService } from '../../core/services/fund.service';
import { Fund } from '../../core/models/fund.model';
import { AuthStore } from '../../core/stores/auth.store';
import { PageHeaderComponent } from '../../shared/components/page-header/page-header.component';
import { GsapFadeDirective } from '../../shared/directives/gsap-fade.directive';
import { ToastService } from '../../shared/components/toast/toast.service';
import { ConfirmationService } from '../../shared/components/confirmation-modal/confirmation.service';

@Component({
  selector: 'app-funds',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule, PageHeaderComponent, GsapFadeDirective],
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
    this.fundService.getAllFunds().subscribe({
      next: (data) => this.funds.set(data),
      error: () => this.toast.error('Failed to load fund requests')
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

    this.fundService.createFund(fundData).subscribe({
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

  updateStatus(fund: Fund, status: 'APPROVED' | 'REJECTED') {
    const actionText = status === 'APPROVED' ? 'approve' : 'reject';
    const intent = status === 'APPROVED' ? 'primary' : 'danger';

    this.confirmationService.confirm({
      title: `${status === 'APPROVED' ? 'Approve' : 'Reject'} Fund Request`,
      message: `Are you sure you want to ${actionText} the fund request "${fund.title}" for $${fund.amountOfFund}?`,
      confirmText: `Yes, ${actionText}`,
      cancelText: 'Cancel',
      isDanger: status === 'REJECTED'
    }).then(confirmed => {
      if (confirmed) {
        this.fundService.updateFundStatus(fund.id, status).subscribe({
          next: () => {
            this.toast.success(`Fund request ${status.toLowerCase()} successfully`);
            this.loadFunds();
          },
          error: () => this.toast.error(`Failed to ${actionText} fund request`)
        });
      }
    });
  }

  // Getters for form validation
  get f() { return this.fundForm.controls; }
}
