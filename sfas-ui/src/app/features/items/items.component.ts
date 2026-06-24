import { Component, inject, OnInit, signal, DestroyRef } from '@angular/core';
import { takeUntilDestroyed } from '@angular/core/rxjs-interop';
import { FormBuilder, ReactiveFormsModule, Validators } from '@angular/forms';
import { ItemService } from '../../core/services/item.service';
import { Item, ItemRequest } from '../../core/models/item.model';
import { AuthStore } from '../../core/stores/auth.store';
import { PageHeaderComponent } from '../../shared/components/page-header/page-header.component';
import { GsapFadeDirective } from '../../shared/directives/gsap-fade.directive';
import { TextInputComponent } from '../../shared/components/text-input/text-input.component';
import { ToastService } from '../../shared/components/toast/toast.service';
import { ConfirmationService } from '../../shared/components/confirmation-modal/confirmation.service';
import { EmptyStateComponent } from '../../shared/components/empty-state/empty-state.component';
import { CurrencyPipe } from '@angular/common';

@Component({
  selector: 'app-items',
  standalone: true,
  imports: [ReactiveFormsModule, PageHeaderComponent, GsapFadeDirective, TextInputComponent, EmptyStateComponent, CurrencyPipe],
  templateUrl: './items.component.html',
  styleUrl: './items.component.css'
})
export class ItemsComponent implements OnInit {
  private itemService = inject(ItemService);
  private fb = inject(FormBuilder);
  private toast = inject(ToastService);
  private confirmation = inject(ConfirmationService);
  authStore = inject(AuthStore);

  items = signal<Item[]>([]);
  showAddModal = signal(false);
  isSubmitting = signal(false);
  isEditing = signal(false);
  currentItemId = signal<string | null>(null);
  isLoading = signal(true);
  private destroyRef = inject(DestroyRef);

  itemForm = this.fb.group({
    name: ['', [Validators.required, Validators.minLength(2)]],
    description: [''],
    price: [0, [Validators.required, Validators.min(0.01)]],
    category: ['']
  });

  ngOnInit() {
    this.loadItems();
  }

  loadItems() {
    this.isLoading.set(true);
    this.itemService.getAllItems()
      .pipe(takeUntilDestroyed(this.destroyRef))
      .subscribe({
        next: (data) => {
          this.items.set(data);
          this.isLoading.set(false);
        },
        error: (err) => {
          this.toast.error('Failed to load items');
          this.isLoading.set(false);
        }
      });
  }

  openAddModal() {
    this.isEditing.set(false);
    this.currentItemId.set(null);
    this.itemForm.reset({ price: 0 });
    this.showAddModal.set(true);
  }

  openEditModal(item: Item) {
    this.isEditing.set(true);
    this.currentItemId.set(item.id);
    this.itemForm.patchValue({
      name: item.name,
      description: item.description || '',
      price: item.price,
      category: item.category || ''
    });
    this.showAddModal.set(true);
  }

  closeAddModal() {
    this.showAddModal.set(false);
  }

  submitItem() {
    if (this.itemForm.invalid) {
      this.itemForm.markAllAsTouched();
      return;
    }

    this.isSubmitting.set(true);
    const itemData = this.itemForm.value as ItemRequest;

    if (this.isEditing() && this.currentItemId()) {
      this.itemService.updateItem(this.currentItemId()!, itemData)
        .pipe(takeUntilDestroyed(this.destroyRef))
        .subscribe({
          next: () => {
            this.toast.success('Item updated successfully');
            this.loadItems();
            this.closeAddModal();
            this.isSubmitting.set(false);
          },
          error: (err) => {
            this.toast.error('Failed to update item');
            this.isSubmitting.set(false);
          }
        });
    } else {
      this.itemService.createItem(itemData)
        .pipe(takeUntilDestroyed(this.destroyRef))
        .subscribe({
          next: () => {
            this.toast.success('Item added successfully');
            this.loadItems();
            this.closeAddModal();
            this.isSubmitting.set(false);
          },
          error: (err) => {
            this.toast.error('Failed to add item');
            this.isSubmitting.set(false);
          }
        });
    }
  }

  async deleteItem(id: string) {
    const confirmed = await this.confirmation.confirm({
      title: 'Delete Item',
      message: 'Are you sure you want to delete this item? This action cannot be undone.',
      confirmText: 'Delete',
      isDanger: true
    });

    if (confirmed) {
      this.itemService.deleteItem(id)
        .pipe(takeUntilDestroyed(this.destroyRef))
        .subscribe({
          next: () => {
            this.toast.success('Item deleted successfully');
            this.loadItems();
          },
          error: (err) => {
            this.toast.error('Failed to delete item');
          }
        });
    }
  }

  // Getters for form validation
  get f() { return this.itemForm.controls; }
}
