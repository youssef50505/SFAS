import { Component, inject, OnInit, signal, DestroyRef } from '@angular/core';
import { takeUntilDestroyed } from '@angular/core/rxjs-interop';
import { DatePipe, CurrencyPipe, NgClass } from '@angular/common';
import { FormBuilder, ReactiveFormsModule, Validators } from '@angular/forms';
import { ReportService } from '../../core/services/report.service';
import { Report } from '../../core/models/report.model';
import { AuthStore } from '../../core/stores/auth.store';
import { PageHeaderComponent } from '../../shared/components/page-header/page-header.component';
import { GsapFadeDirective } from '../../shared/directives/gsap-fade.directive';
import { ToastService } from '../../shared/components/toast/toast.service';

@Component({
  selector: 'app-reports',
  standalone: true,
  imports: [DatePipe, NgClass, ReactiveFormsModule, PageHeaderComponent, GsapFadeDirective],
  templateUrl: './reports.component.html',
  styleUrl: './reports.component.css'
})
export class ReportsComponent implements OnInit {
  private reportService = inject(ReportService);
  private fb = inject(FormBuilder);
  private toast = inject(ToastService);
  authStore = inject(AuthStore);

  reports = signal<Report[]>([]);
  showAddModal = signal(false);
  isSubmitting = signal(false);
  isLoading = signal(true);
  private destroyRef = inject(DestroyRef);

  reportForm = this.fb.group({
    title: ['', [Validators.required, Validators.minLength(3)]],
    description: ['', [Validators.required, Validators.minLength(10)]],
    date: [new Date().toISOString().slice(0, 16), [Validators.required]],
    typeOfReport: ['IN_APP', [Validators.required]]
  });

  ngOnInit() {
    this.loadReports();
  }

  loadReports() {
    this.isLoading.set(true);
    this.reportService.getAllReports()
      .pipe(takeUntilDestroyed(this.destroyRef))
      .subscribe({
        next: (data) => {
          this.reports.set(data);
          this.isLoading.set(false);
        },
        error: () => {
          this.toast.error('Failed to load reports');
          this.isLoading.set(false);
        }
      });
  }

  openAddModal() {
    this.reportForm.reset({
      date: new Date().toISOString().slice(0, 16),
      typeOfReport: 'IN_APP'
    });
    this.showAddModal.set(true);
  }

  closeAddModal() {
    this.showAddModal.set(false);
  }

  submitReport() {
    if (this.reportForm.invalid) {
      this.reportForm.markAllAsTouched();
      return;
    }

    this.isSubmitting.set(true);
    const reportData = this.reportForm.value as Partial<Report>;

    this.reportService.createReport(reportData)
      .pipe(takeUntilDestroyed(this.destroyRef))
      .subscribe({
        next: () => {
          this.toast.success('Report generated successfully');
          this.loadReports();
          this.closeAddModal();
          this.isSubmitting.set(false);
        },
        error: () => {
          this.toast.error('Failed to generate report');
          this.isSubmitting.set(false);
        }
      });
  }

  // Getters for form validation
  get f() { return this.reportForm.controls; }
}
