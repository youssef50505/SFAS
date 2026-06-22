import { Injectable, inject, signal } from '@angular/core';
import { CollectionService } from '../../../core/services/collection.service';
import { Collection } from '../../../core/models/collection.model';
import { ToastService } from '../../../shared/components/toast/toast.service';
import { tap, catchError, EMPTY } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class CollectionStore {
  private collectionService = inject(CollectionService);
  private toast = inject(ToastService);

  collections = signal<Collection[]>([]);
  isLoading = signal(true);
  isSubmitting = signal(false);

  loadCollections() {
    this.isLoading.set(true);
    return this.collectionService.getAllCollections().pipe(
      tap({
        next: (data) => {
          this.collections.set(data);
          this.isLoading.set(false);
        },
        error: () => {
          this.toast.error('Failed to load collections');
          this.isLoading.set(false);
        }
      }),
      catchError(() => EMPTY)
    );
  }

  createCollection(collectionData: Partial<Collection>) {
    this.isSubmitting.set(true);
    return this.collectionService.createCollection(collectionData).pipe(
      tap({
        next: () => {
          this.toast.success('Collection recorded successfully');
          this.isSubmitting.set(false);
        },
        error: () => {
          this.toast.error('Failed to record collection');
          this.isSubmitting.set(false);
        }
      }),
      catchError(() => EMPTY)
    );
  }
}
