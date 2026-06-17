import { Component, inject, OnInit, signal, DestroyRef } from '@angular/core';
import { takeUntilDestroyed } from '@angular/core/rxjs-interop';
import { DatePipe, CurrencyPipe, NgClass } from '@angular/common';
import { FormBuilder, ReactiveFormsModule, Validators } from '@angular/forms';
import { CollectionService } from '../../core/services/collection.service';
import { Collection } from '../../core/models/collection.model';
import { AuthStore } from '../../core/stores/auth.store';
import { PageHeaderComponent } from '../../shared/components/page-header/page-header.component';
import { GsapFadeDirective } from '../../shared/directives/gsap-fade.directive';
import { ToastService } from '../../shared/components/toast/toast.service';

@Component({
  selector: 'app-collections',
  standalone: true,
  imports: [DatePipe, CurrencyPipe, NgClass, ReactiveFormsModule, PageHeaderComponent, GsapFadeDirective],
  templateUrl: './collections.component.html',
  styleUrl: './collections.component.css'
})
export class CollectionsComponent implements OnInit {
  private collectionService = inject(CollectionService);
  private fb = inject(FormBuilder);
  private toast = inject(ToastService);
  authStore = inject(AuthStore);

  collections = signal<Collection[]>([]);
  showAddModal = signal(false);
  isSubmitting = signal(false);
  isLoading = signal(true);
  private destroyRef = inject(DestroyRef);

  collectionForm = this.fb.group({
    date: [new Date().toISOString().split('T')[0], [Validators.required]],
    type: ['DAILY', [Validators.required]],
    amount: [null as number | null, [Validators.required, Validators.min(0.01)]]
  });

  ngOnInit() {
    this.loadCollections();
  }

  loadCollections() {
    this.isLoading.set(true);
    this.collectionService.getAllCollections()
      .pipe(takeUntilDestroyed(this.destroyRef))
      .subscribe({
        next: (data) => {
          this.collections.set(data);
          this.isLoading.set(false);
        },
        error: () => {
          this.toast.error('Failed to load collections');
          this.isLoading.set(false);
        }
      });
  }

  openAddModal() {
    this.collectionForm.reset({
      date: new Date().toISOString().split('T')[0],
      type: 'DAILY'
    });
    this.showAddModal.set(true);
  }

  closeAddModal() {
    this.showAddModal.set(false);
  }

  submitCollection() {
    if (this.collectionForm.invalid) {
      this.collectionForm.markAllAsTouched();
      return;
    }

    this.isSubmitting.set(true);
    const collectionData = this.collectionForm.value as Partial<Collection>;

    this.collectionService.createCollection(collectionData)
      .pipe(takeUntilDestroyed(this.destroyRef))
      .subscribe({
        next: () => {
          this.toast.success('Collection recorded successfully');
          this.loadCollections();
          this.closeAddModal();
          this.isSubmitting.set(false);
        },
        error: () => {
          this.toast.error('Failed to record collection');
          this.isSubmitting.set(false);
        }
      });
  }

  // Getters for form validation
  get f() { return this.collectionForm.controls; }
}
