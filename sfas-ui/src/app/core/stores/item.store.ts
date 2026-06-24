import { Injectable, signal, computed, inject } from '@angular/core';
import { Item } from '../models/item.model';
import { ItemService } from '../services/item.service';

@Injectable({
  providedIn: 'root'
})
export class ItemStore {
  private itemService = inject(ItemService);

  private itemsSignal = signal<Item[]>([]);
  private loadingSignal = signal<boolean>(false);
  private errorSignal = signal<string | null>(null);

  public readonly items = computed(() => this.itemsSignal());
  public readonly isLoading = computed(() => this.loadingSignal());
  public readonly error = computed(() => this.errorSignal());

  public loadItems(): void {
    this.loadingSignal.set(true);
    this.errorSignal.set(null);
    this.itemService.getAllItems().subscribe({
      next: (items) => {
        this.itemsSignal.set(items);
        this.loadingSignal.set(false);
      },
      error: (err) => {
        console.error('Failed to load items', err);
        this.errorSignal.set('Failed to load items');
        this.loadingSignal.set(false);
      }
    });
  }

  public addItem(item: Item): void {
    this.itemsSignal.update(items => [...items, item]);
  }

  public updateItem(updatedItem: Item): void {
    this.itemsSignal.update(items =>
      items.map(item => item.id === updatedItem.id ? updatedItem : item)
    );
  }

  public removeItem(id: string): void {
    this.itemsSignal.update(items => items.filter(item => item.id !== id));
  }
}
