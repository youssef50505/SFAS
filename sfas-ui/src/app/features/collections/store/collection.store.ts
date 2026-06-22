import { Injectable, inject, signal } from '@angular/core';
import { CollectionService } from '../../../core/services/collection.service';
import { CollectionMetrics } from '../../../core/models/collection.model';
import { ToastService } from '../../../shared/components/toast/toast.service';
import { tap, catchError, EMPTY } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class CollectionStore {
  private collectionService = inject(CollectionService);
  private toast = inject(ToastService);

  metrics = signal<CollectionMetrics | null>(null);
  isLoading = signal(true);

  loadMetrics() {
    this.isLoading.set(true);
    return this.collectionService.getCollectionMetrics().pipe(
      tap({
        next: (data) => {
          this.metrics.set(data);
          this.isLoading.set(false);
        },
        error: () => {
          this.toast.error('Failed to load collection metrics');
          this.isLoading.set(false);
        }
      }),
      catchError(() => EMPTY)
    );
  }
}
