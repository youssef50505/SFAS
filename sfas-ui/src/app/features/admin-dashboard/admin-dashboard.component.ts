import { Component, inject, OnInit, ViewChild, signal, DestroyRef } from '@angular/core';
import { CurrencyPipe } from '@angular/common';
import { takeUntilDestroyed } from '@angular/core/rxjs-interop';
import { PageHeaderComponent } from '../../shared/components/page-header/page-header.component';
import { MetricCardComponent } from '../../shared/components/metric-card/metric-card.component';
import { GsapFadeDirective } from '../../shared/directives/gsap-fade.directive';
import { AdminDashboardStore } from './admin-dashboard.store';
import { NgApexchartsModule, ChartComponent, ApexAxisChartSeries, ApexChart, ApexXAxis, ApexTitleSubtitle, ApexStroke, ApexDataLabels, ApexFill, ApexTooltip } from 'ng-apexcharts';

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
  imports: [CurrencyPipe, NgApexchartsModule, PageHeaderComponent, MetricCardComponent, GsapFadeDirective],
  templateUrl: './admin-dashboard.component.html',
  styleUrl: './admin-dashboard.component.css'
})
export class AdminDashboardComponent implements OnInit {
  store = inject(AdminDashboardStore);

  @ViewChild("chart") chart!: ChartComponent;
  public chartOptions!: ChartOptions;

  private destroyRef = inject(DestroyRef);

  ngOnInit() {
    this.initChart();
    this.store.loadDashboardData().pipe(takeUntilDestroyed(this.destroyRef)).subscribe({
      next: () => {
        this.chartOptions.xaxis = { categories: this.store.chartCategories() };
        this.chartOptions.series = this.store.chartSeries();
      }
    });
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
      tooltip: { shared: true, intersect: false, y: { formatter: function (y) { if(typeof y !== "undefined") { return "EGP " + y.toFixed(0); } return y; } } }
    };
  }
}
