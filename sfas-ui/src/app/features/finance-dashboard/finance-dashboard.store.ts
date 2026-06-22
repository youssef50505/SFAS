import { Injectable, inject, signal } from '@angular/core';
import { BillService } from '../../core/services/bill.service';
import { FundService } from '../../core/services/fund.service';
import { DocumentStatus } from '../../core/models/status.enum';
import { forkJoin, tap, catchError, EMPTY } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class FinanceDashboardStore {
  private billService = inject(BillService);
  private fundService = inject(FundService);

  pendingBillsCount = signal(0);
  pendingFundsCount = signal(0);
  isLoading = signal(true);
  error = signal<string | null>(null);

  loadData() {
    this.isLoading.set(true);
    this.error.set(null);

    return forkJoin({
      bills: this.billService.getAllBills(),
      funds: this.fundService.getAllFunds()
    }).pipe(
      tap({
        next: ({ bills, funds }) => {
          const pendingBills = bills.filter(b => b.status === DocumentStatus.PENDING).length;
          this.pendingBillsCount.set(pendingBills);

          const pendingFunds = funds.filter(f => f.status === DocumentStatus.PENDING).length;
          this.pendingFundsCount.set(pendingFunds);

          this.isLoading.set(false);
        },
        error: (err) => {
          console.error('Error loading finance data', err);
          this.error.set('Failed to load finance data');
          this.isLoading.set(false);
        }
      }),
      catchError(() => EMPTY)
    );
  }
}
