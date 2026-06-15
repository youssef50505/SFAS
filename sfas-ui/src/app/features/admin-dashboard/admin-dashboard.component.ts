import { Component, inject, OnInit, ViewChild, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { PageHeaderComponent } from '../../shared/components/page-header/page-header.component';
import { MetricCardComponent } from '../../shared/components/metric-card/metric-card.component';
import { GsapFadeDirective } from '../../shared/directives/gsap-fade.directive';
import { BillService } from '../../core/services/bill.service';
import { FundService } from '../../core/services/fund.service';
import { CollectionService } from '../../core/services/collection.service';
import { NgApexchartsModule, ChartComponent, ApexAxisChartSeries, ApexChart, ApexXAxis, ApexTitleSubtitle, ApexStroke, ApexDataLabels, ApexFill, ApexTooltip } from 'ng-apexcharts';
import { forkJoin } from 'rxjs';

export type ChartOptions = {
  series: ApexAxisChartSeries;
  chart: ApexChart;
  xaxis: ApexXAxis;
  title: ApexTitleSubtitle;
  stroke: ApexStroke;
  dataLabels: ApexDataLabels;
  fill: ApexFill;
  tooltip: ApexTooltip;
  colors: string[];
};

@Component({
  selector: 'app-admin-dashboard',
  standalone: true,
  imports: [CommonModule, NgApexchartsModule, PageHeaderComponent, MetricCardComponent, GsapFadeDirective],
  templateUrl: './admin-dashboard.component.html',
  styleUrl: './admin-dashboard.component.css'
})
export class AdminDashboardComponent implements OnInit {
  billService = inject(BillService);
  fundService = inject(FundService);
  collectionService = inject(CollectionService);

  @ViewChild("chart") chart!: ChartComponent;
  public chartOptions!: ChartOptions;

  // Signals for dynamic metrics
  totalCollections = signal(0);
  pendingBillsCount = signal(0);
  activeFundsCount = signal(0);
  isLoading = signal(true);

  ngOnInit() {
    this.initChart();
    this.loadDashboardData();
  }

  private initChart() {
    this.chartOptions = {
      series: [
        { name: "Collections", type: "column", data: [0, 0, 0, 0, 0, 0] },
        { name: "Bills", type: "area", data: [0, 0, 0, 0, 0, 0] }
      ],
      chart: { height: 350, type: "line", fontFamily: 'Inter, sans-serif', toolbar: { show: false } },
      stroke: { width: [0, 3], curve: 'smooth' },
      dataLabels: { enabled: true, enabledOnSeries: [0] },
      colors: ['#059669', '#4f46e5'], // Emerald 600, Indigo 600
      fill: { type: 'solid', opacity: [1, 0.2] },
      xaxis: { categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'] },
      title: { text: 'Monthly Financial Overview', align: 'left', style: { fontSize: '18px', fontWeight: '600', color: 'var(--text-primary)' } },
      tooltip: { shared: true, intersect: false, y: { formatter: function (y) { if(typeof y !== "undefined") { return "$" + y.toFixed(0); } return y; } } }
    };
  }

  private loadDashboardData() {
    forkJoin({
      bills: this.billService.getAllBills(),
      funds: this.fundService.getAllFunds(),
      collections: this.collectionService.getAllCollections()
    }).subscribe({
      next: ({ bills, funds, collections }) => {
        // Calculate Metrics
        const totalColl = collections.reduce((sum, coll) => sum + coll.amount, 0);
        this.totalCollections.set(totalColl);

        const pendingBills = bills.filter(b => b.status === 'PENDING').length;
        this.pendingBillsCount.set(pendingBills);

        const activeFunds = funds.filter(f => f.status === 'PENDING').length;
        this.activeFundsCount.set(activeFunds);

        // Calculate chart data (Dummy calculation for past 6 months to showcase interaction)
        // In a real app, we would group the dates properly.
        const currentMonth = new Date().getMonth();
        const collectionData = [0, 0, 0, 0, 0, 0];
        const billData = [0, 0, 0, 0, 0, 0];
        
        // Simplified grouping for demo
        collections.forEach(c => {
           const m = new Date(c.date).getMonth();
           if (m <= currentMonth && currentMonth - m < 6) {
             const idx = 5 - (currentMonth - m);
             if(idx >= 0) collectionData[idx] += c.amount;
           }
        });

        bills.forEach(b => {
           const m = new Date(b.date).getMonth();
           if (m <= currentMonth && currentMonth - m < 6) {
             const idx = 5 - (currentMonth - m);
             if(idx >= 0) billData[idx] += b.amount;
           }
        });

        const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
        const categories = [];
        for (let i = 5; i >= 0; i--) {
          let m = currentMonth - i;
          if (m < 0) m += 12;
          categories.push(months[m]);
        }

        this.chartOptions.xaxis = { categories };
        this.chartOptions.series = [
          { name: "Collections", type: "column", data: collectionData },
          { name: "Bills", type: "area", data: billData }
        ];

        this.isLoading.set(false);
      },
      error: (err) => {
        console.error('Error loading dashboard data', err);
        this.isLoading.set(false);
      }
    });
  }
}
