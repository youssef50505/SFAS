import { Component, inject, OnInit, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { PageHeaderComponent } from '../../shared/components/page-header/page-header.component';
import { MetricCardComponent } from '../../shared/components/metric-card/metric-card.component';
import { GsapFadeDirective } from '../../shared/directives/gsap-fade.directive';
import { BillService } from '../../core/services/bill.service';
import { FundService } from '../../core/services/fund.service';
import { forkJoin } from 'rxjs';
import { RouterModule } from '@angular/router';

@Component({
  selector: 'app-finance-dashboard',
  standalone: true,
  imports: [CommonModule, PageHeaderComponent, MetricCardComponent, GsapFadeDirective, RouterModule],
  templateUrl: './finance-dashboard.component.html',
  styleUrl: './finance-dashboard.component.css'
})
export class FinanceDashboardComponent implements OnInit {
  private billService = inject(BillService);
  private fundService = inject(FundService);

  pendingBillsCount = signal(0);
  pendingFundsCount = signal(0);
  isLoading = signal(true);

  ngOnInit() {
    this.loadData();
  }

  private loadData() {
    forkJoin({
      bills: this.billService.getAllBills(),
      funds: this.fundService.getAllFunds()
    }).subscribe({
      next: ({ bills, funds }) => {
        const pendingBills = bills.filter(b => b.status === 'PENDING').length;
        this.pendingBillsCount.set(pendingBills);

        const pendingFunds = funds.filter(f => f.status === 'PENDING').length;
        this.pendingFundsCount.set(pendingFunds);

        this.isLoading.set(false);
      },
      error: (err) => {
        console.error('Error loading finance data', err);
        this.isLoading.set(false);
      }
    });
  }
}
