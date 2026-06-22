import { Injectable, inject, signal } from '@angular/core';
import { ReportService } from '../../../core/services/report.service';
import { Report } from '../../../core/models/report.model';
import { ToastService } from '../../../shared/components/toast/toast.service';
import { tap, catchError, EMPTY } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ReportStore {
  private reportService = inject(ReportService);
  private toast = inject(ToastService);

  reports = signal<Report[]>([]);
  isLoading = signal(true);
  isSubmitting = signal(false);

  loadReports() {
    this.isLoading.set(true);
    return this.reportService.getAllReports().pipe(
      tap({
        next: (data) => {
          this.reports.set(data);
          this.isLoading.set(false);
        },
        error: () => {
          this.toast.error('Failed to load reports');
          this.isLoading.set(false);
        }
      }),
      catchError(() => EMPTY)
    );
  }

  createReport(reportData: Partial<Report>) {
    this.isSubmitting.set(true);
    return this.reportService.createReport(reportData).pipe(
      tap({
        next: () => {
          this.toast.success('Report generated successfully');
          this.isSubmitting.set(false);
        },
        error: () => {
          this.toast.error('Failed to generate report');
          this.isSubmitting.set(false);
        }
      }),
      catchError(() => EMPTY)
    );
  }
}
