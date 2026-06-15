import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ReportItem } from '../report-item/report-item';

@Component({
  selector: 'app-reports-history',
  standalone: true,
  imports: [CommonModule, ReportItem],
  templateUrl: './reports-history.html',
  styleUrls: ['./reports-history.css'],
})
export class ReportsHistory {}
