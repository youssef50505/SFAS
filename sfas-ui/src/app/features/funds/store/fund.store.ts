import { Injectable, inject, signal } from '@angular/core';
import { FundService } from '../../../core/services/fund.service';
import { Fund } from '../../../core/models/fund.model';
import { ToastService } from '../../../shared/components/toast/toast.service';
import { DocumentStatus } from '../../../core/models/status.enum';
import { tap, catchError, EMPTY } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class FundStore {
  private fundService = inject(FundService);
  private toast = inject(ToastService);

  funds = signal<Fund[]>([]);
  isLoading = signal(true);
  isSubmitting = signal(false);

  loadFunds() {
    this.isLoading.set(true);
    return this.fundService.getAllFunds().pipe(
      tap({
        next: (data) => {
          this.funds.set(data);
          this.isLoading.set(false);
        },
        error: () => {
          this.toast.error('Failed to load fund requests');
          this.isLoading.set(false);
        }
      }),
      catchError(() => EMPTY)
    );
  }

  createFund(fundData: Partial<Fund>) {
    this.isSubmitting.set(true);
    return this.fundService.createFund(fundData).pipe(
      tap({
        next: () => {
          this.toast.success('Fund request submitted successfully');
          this.isSubmitting.set(false);
        },
        error: () => {
          this.toast.error('Failed to submit fund request');
          this.isSubmitting.set(false);
        }
      }),
      catchError(() => EMPTY)
    );
  }

  updateFundStatus(id: string, status: DocumentStatus, comments: string) {
    return this.fundService.updateFundStatus(id, status, comments).pipe(
      tap({
        next: () => {
          this.toast.success(`Fund request ${status.toLowerCase()} successfully`);
        },
        error: () => {
          const actionText = status === DocumentStatus.APPROVED ? 'approve' : (status === DocumentStatus.REJECTED ? 'reject' : 'mark pending');
          this.toast.error(`Failed to ${actionText} fund request`);
        }
      }),
      catchError(() => EMPTY)
    );
  }
}
