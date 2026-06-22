import { Component, inject, OnInit, signal, DestroyRef } from '@angular/core';
import { takeUntilDestroyed } from '@angular/core/rxjs-interop';
import { DatePipe, CurrencyPipe, NgClass } from '@angular/common';
import { FormBuilder, ReactiveFormsModule, Validators } from '@angular/forms';
import { Collection } from '../../core/models/collection.model';
import { AuthStore } from '../../core/stores/auth.store';
import { CollectionType } from '../../core/models/status.enum';
import { PageHeaderComponent } from '../../shared/components/page-header/page-header.component';
import { GsapFadeDirective } from '../../shared/directives/gsap-fade.directive';
import { CollectionStore } from './store/collection.store';

@Component({
  selector: 'app-collections',
  standalone: true,
  imports: [DatePipe, CurrencyPipe, NgClass, ReactiveFormsModule, PageHeaderComponent, GsapFadeDirective],
  templateUrl: './collections.component.html',
  styleUrl: './collections.component.css'
})
export class CollectionsComponent implements OnInit {
  store = inject(CollectionStore);
  private fb = inject(FormBuilder);
  authStore = inject(AuthStore);

  showAddModal = signal(false);
  private destroyRef = inject(DestroyRef);

  collectionForm = this.fb.group({
    date: [new Date().toISOString().split('T')[0], [Validators.required]],
    type: [CollectionType.DAILY as string, [Validators.required]],
    amount: [null as number | null, [Validators.required, Validators.min(0.01)]]
  });

  ngOnInit() {
    this.store.loadCollections().pipe(takeUntilDestroyed(this.destroyRef)).subscribe();
  }

  openAddModal() {
    this.collectionForm.reset({
      date: new Date().toISOString().split('T')[0],
      type: CollectionType.DAILY as string
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

    const collectionData = this.collectionForm.value as Partial<Collection>;

    this.store.createCollection(collectionData)
      .pipe(takeUntilDestroyed(this.destroyRef))
      .subscribe({
        next: () => {
          this.store.loadCollections().pipe(takeUntilDestroyed(this.destroyRef)).subscribe();
          this.closeAddModal();
        }
      });
  }

  // Getters for form validation
  get f() { return this.collectionForm.controls; }
}
