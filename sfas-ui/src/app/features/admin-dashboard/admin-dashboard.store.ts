import { Injectable, inject, signal } from '@angular/core';
import { BillService } from '../../core/services/bill.service';
import { FundService } from '../../core/services/fund.service';
import { CollectionService } from '../../core/services/collection.service';
import { DocumentStatus } from '../../core/models/status.enum';
import { forkJoin, tap, catchError, EMPTY } from 'rxjs';
import { ChartOptions } from './admin-dashboard.component';

@Injectable({
  providedIn: 'root'
})
export class AdminDashboardStore {
  private billService = inject(BillService);
  private fundService = inject(FundService);
  private collectionService = inject(CollectionService);

  totalCollections = signal(0);
  pendingBillsCount = signal(0);
  activeFundsCount = signal(0);
  isLoading = signal(true);
  error = signal<string | null>(null);

  chartSeries = signal<any[]>([]);
  chartCategories = signal<string[]>([]);

  loadDashboardData() {
    this.isLoading.set(true);
    this.error.set(null);

    return forkJoin({
      bills: this.billService.getAllBills(),
      funds: this.fundService.getAllFunds(),
      metrics: this.collectionService.getCollectionMetrics()
    }).pipe(
      tap({
        next: ({ bills, funds, metrics }) => {
          this.totalCollections.set(metrics.annually);

          const pendingBills = bills.filter(b => b.status === DocumentStatus.PENDING).length;
          this.pendingBillsCount.set(pendingBills);

          const activeFunds = funds.filter(f => f.status === DocumentStatus.PENDING).length;
          this.activeFundsCount.set(activeFunds);

          const currentMonth = new Date().getMonth();
          const billData = [0, 0, 0, 0, 0, 0];
          
          bills.forEach(b => {
             const m = new Date(b.date).getMonth();
             if (m <= currentMonth && currentMonth - m < 6) {
               const idx = 5 - (currentMonth - m);
               if(idx >= 0) {
                 billData[idx] += b.amount;
               }
             }
          });

          const collectionData = [...billData]; // Since collections are derived directly from all bills

          const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
          const categories = [];
          for (let i = 5; i >= 0; i--) {
            let m = currentMonth - i;
            if (m < 0) m += 12;
            categories.push(months[m]);
          }

          this.chartCategories.set(categories);
          this.chartSeries.set([
            { name: "Collections", type: "column", data: collectionData },
            { name: "Bills", type: "area", data: billData }
          ]);

          this.isLoading.set(false);
        },
        error: (err) => {
          console.error('Error loading dashboard data', err);
          this.error.set('Failed to load dashboard data');
          this.isLoading.set(false);
        }
      }),
      catchError(() => EMPTY)
    );
  }
}
