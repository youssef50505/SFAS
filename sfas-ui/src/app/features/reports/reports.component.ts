import { Component, inject, OnInit, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
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
  imports: [CommonModule, ReactiveFormsModule, PageHeaderComponent, GsapFadeDirective],
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
    this.reportService.getAllReports().subscribe({
      next: (data) => this.reports.set(data),
      error: () => this.toast.error('Failed to load reports')
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

    this.reportService.createReport(reportData).subscribe({
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
