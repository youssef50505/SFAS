import { Injectable, inject, signal } from '@angular/core';
import { BillService } from '../../../core/services/bill.service';
import { VendorService } from '../../../core/services/vendor.service';
import { Bill } from '../../../core/models/bill.model';
import { Vendor } from '../../../core/models/vendor.model';
import { ToastService } from '../../../shared/components/toast/toast.service';
import { DocumentStatus } from '../../../core/models/status.enum';
import { tap, catchError, EMPTY } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class BillStore {
  private billService = inject(BillService);
  private vendorService = inject(VendorService);
  private toast = inject(ToastService);

  bills = signal<Bill[]>([]);
  vendors = signal<Vendor[]>([]);
  isLoading = signal(true);
  isSubmitting = signal(false);

  loadBills() {
    this.isLoading.set(true);
    return this.billService.getAllBills().pipe(
      tap({
        next: (data) => {
          this.bills.set(data);
          this.isLoading.set(false);
        },
        error: () => {
          this.toast.error('Failed to load bills');
          this.isLoading.set(false);
        }
      }),
      catchError(() => EMPTY)
    );
  }

  loadVendors() {
    return this.vendorService.getAllVendors().pipe(
      tap({
        next: (data) => this.vendors.set(data),
        error: () => this.toast.error('Failed to load vendors')
      }),
      catchError(() => EMPTY)
    );
  }

  createBill(billData: Partial<Bill>) {
    this.isSubmitting.set(true);
    return this.billService.createBill(billData).pipe(
      tap({
        next: () => {
          this.toast.success('Bill created successfully');
          this.isSubmitting.set(false);
        },
        error: () => {
          this.toast.error('Failed to create bill');
          this.isSubmitting.set(false);
        }
      }),
      catchError(() => EMPTY)
    );
  }

  updateBillStatus(id: string, status: DocumentStatus, comments: string) {
    return this.billService.updateBillStatus(id, status, comments).pipe(
      tap({
        next: () => {
          this.toast.success(`Bill ${status.toLowerCase()} successfully`);
        },
        error: () => {
          const actionText = status === DocumentStatus.APPROVED ? 'approve' : (status === DocumentStatus.REJECTED ? 'reject' : 'mark pending');
          this.toast.error(`Failed to ${actionText} bill`);
        }
      }),
      catchError(() => EMPTY)
    );
  }
}
