import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FileUpload } from '../file-upload/file-upload';
import { ReportTypeSelector } from '../report-type-selector/report-type-selector';

@Component({
  selector: 'app-new-report-form',
  standalone: true,
  imports: [CommonModule, FileUpload, ReportTypeSelector],
  templateUrl: './new-report-form.html',
  styleUrls: ['./new-report-form.css'],
})
export class NewReportForm {}
