import { Component, inject, OnInit, signal, DestroyRef } from '@angular/core';
import { takeUntilDestroyed } from '@angular/core/rxjs-interop';
import { PageHeaderComponent } from '../../shared/components/page-header/page-header.component';
import { MetricCardComponent } from '../../shared/components/metric-card/metric-card.component';
import { GsapFadeDirective } from '../../shared/directives/gsap-fade.directive';
import { BillService } from '../../core/services/bill.service';
import { FundService } from '../../core/services/fund.service';
import { forkJoin } from 'rxjs';
import { RouterModule } from '@angular/router';
import { DocumentStatus } from '../../core/models/status.enum';
import { FinanceDashboardStore } from './finance-dashboard.store';

@Component({
  selector: 'app-finance-dashboard',
  standalone: true,
  imports: [PageHeaderComponent, MetricCardComponent, GsapFadeDirective, RouterModule],
  templateUrl: './finance-dashboard.component.html',
  styleUrl: './finance-dashboard.component.css'
})
export class FinanceDashboardComponent implements OnInit {
  store = inject(FinanceDashboardStore);
  private destroyRef = inject(DestroyRef);

  ngOnInit() {
    this.store.loadData().pipe(takeUntilDestroyed(this.destroyRef)).subscribe();
  }
}
