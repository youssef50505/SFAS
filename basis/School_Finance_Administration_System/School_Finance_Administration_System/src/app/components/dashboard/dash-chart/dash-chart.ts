import { Component } from '@angular/core';
import { ApexAxisChartSeries, ApexChart, ApexStroke, ApexTooltip, ApexXAxis, ApexDataLabels, ApexFill, ChartComponent } from 'ng-apexcharts';

export type ChartOptions = {
  series: ApexAxisChartSeries;
  chart: ApexChart;
  stroke: ApexStroke;
  tooltip: ApexTooltip;
  xaxis: ApexXAxis;
  dataLabels: ApexDataLabels;
  fill: ApexFill;
};

@Component({
  selector: 'app-dash-chart',
  imports: [ChartComponent],
  templateUrl: './dash-chart.html',
  styleUrl: './dash-chart.css',
})

export class DashChart {
  public chartOptions: ChartOptions = {
    series: [
      {
        name: 'Funds Collected',
        data: [120, 220, 180, 350, 420, 390, 600]
      }
    ],

    chart: {
      type: 'area',
      height: 300,
      toolbar: {
        show: false
      },
      zoom: {
        enabled: false
      }
    },

    stroke: {
      curve: 'smooth',
      width: 3
    },

    dataLabels: {
      enabled: false
    },

    fill: {
      type: 'gradient',
      gradient: {
        opacityFrom: 0.4,
        opacityTo: 0.05
      }
    },

    xaxis: {
      categories: [
        'Mon',
        'Tue',
        'Wed',
        'Thu',
        'Fri',
        'Sat',
        'Sun'
      ]
    },

    tooltip: {
      enabled: true
    }
  };

}
