import { Component, inject, OnInit, signal, DestroyRef } from '@angular/core';
import { takeUntilDestroyed } from '@angular/core/rxjs-interop';
import { DatePipe, CurrencyPipe, NgClass } from '@angular/common';
import { FormBuilder, ReactiveFormsModule, Validators } from '@angular/forms';
import { Report } from '../../core/models/report.model';
import { AuthStore } from '../../core/stores/auth.store';
import { ReportType } from '../../core/models/status.enum';
import { PageHeaderComponent } from '../../shared/components/page-header/page-header.component';
import { GsapFadeDirective } from '../../shared/directives/gsap-fade.directive';
import { ReportStore } from './store/report.store';

@Component({
  selector: 'app-reports',
  standalone: true,
  imports: [DatePipe, NgClass, ReactiveFormsModule, PageHeaderComponent, GsapFadeDirective],
  templateUrl: './reports.component.html',
  styleUrl: './reports.component.css'
})
export class ReportsComponent implements OnInit {
  store = inject(ReportStore);
  private fb = inject(FormBuilder);
  authStore = inject(AuthStore);

  showAddModal = signal(false);
  private destroyRef = inject(DestroyRef);

  reportForm = this.fb.group({
    title: ['', [Validators.required, Validators.minLength(3)]],
    description: ['', [Validators.required, Validators.minLength(10)]],
    date: [new Date().toISOString().slice(0, 16), [Validators.required]],
    typeOfReport: [ReportType.IN_APP as string, [Validators.required]]
  });

  ngOnInit() {
    this.store.loadReports().pipe(takeUntilDestroyed(this.destroyRef)).subscribe();
  }

  openAddModal() {
    this.reportForm.reset({
      date: new Date().toISOString().slice(0, 16),
      typeOfReport: ReportType.IN_APP as string
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

    const reportData = this.reportForm.value as Partial<Report>;

    this.store.createReport(reportData)
      .pipe(takeUntilDestroyed(this.destroyRef))
      .subscribe({
        next: () => {
          this.store.loadReports().pipe(takeUntilDestroyed(this.destroyRef)).subscribe();
          this.closeAddModal();
        }
      });
  }

  // Getters for form validation
  get f() { return this.reportForm.controls; }
}
