import { Component, OnDestroy } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { GNav } from "../g-nav/g-nav";
import { GFooter } from "../g-footer/g-footer";
import { NotificationService } from '../services/notification';

interface PreviewImage {
  file: File;
  url: string;
  name: string;
}

interface Bill {
  id: number;
  name: string;
  vendor: string;
  amount: number;
  paymentDate: string;
  justification: string;
  status: 'Pending' | 'Reviewed';
  icon: string;
}

@Component({
  selector: 'app-bill-menagment',
  imports: [CommonModule, FormsModule, GNav, GFooter],
  templateUrl: './bill-menagment.html',
  styleUrl: './bill-menagment.css',
})
export class BillMenagment {
  totalAmount = 24550.00;
  searchQuery = '';
  currentPage = 1;
  itemsPerPage = 4;
  showAddBillModal = false;


  newBill = {
    name: '',
    vendor: '',
    amount: 0,
    paymentDate: '',
    justification: '',
    billPicture: null
  };

  bills: Bill[] = [];
  selectedBillForDetails: Bill | null = null;
  billBeingEdited: Bill | null = null;
  activeDropdownId: number | null = null;

  constructor(private notification: NotificationService) { }

  get filteredBills(): Bill[] {
    if (!this.searchQuery) {
      return this.bills;
    }
    return this.bills.filter(bill =>
      bill.name.toLowerCase().includes(this.searchQuery.toLowerCase()) ||
      bill.vendor.toLowerCase().includes(this.searchQuery.toLowerCase())
    );
  }

  get paginatedBills(): Bill[] {
    const start = (this.currentPage - 1) * this.itemsPerPage;
    return this.filteredBills.slice(start, start + this.itemsPerPage);
  }

  get totalResults(): number {
    return this.filteredBills.length;
  }

  get totalPages(): number {
    return Math.ceil(this.filteredBills.length / this.itemsPerPage);
  }

  onSearch(query: string) {
    this.searchQuery = query;
    this.currentPage = 1;
  }

  nextPage() {
    if (this.currentPage < this.totalPages) {
      this.currentPage++;
    }
  }

  prevPage() {
    if (this.currentPage > 1) {
      this.currentPage--;
    }
  }

  goToPage(page: number) {
    if (page >= 1 && page <= this.totalPages) {
      this.currentPage = page;
    }
  }

  viewDetails(bill: Bill) {
    this.selectedBillForDetails = bill;
  }

  closeDetailsModal() {
    this.selectedBillForDetails = null;
  }

  toggleDropdown(billId: number, event: Event) {
    event.stopPropagation();
    if (this.activeDropdownId === billId) {
      this.activeDropdownId = null;
    } else {
      this.activeDropdownId = billId;
    }
  }

  closeDropdown() {
    this.activeDropdownId = null;
  }

  deleteBill(bill: Bill) {
    this.bills = this.bills.filter(b => b.id !== bill.id);
    this.totalAmount -= bill.amount;
    this.closeDropdown();
    this.notification.success('تم حذف الفاتورة بنجاح!');
  }

  updateBill(bill: Bill) {
    this.billBeingEdited = bill;
    this.newBill = {
      name: bill.name,
      vendor: bill.vendor,
      amount: bill.amount,
      paymentDate: bill.paymentDate,
      justification: bill.justification,
      billPicture: null
    };
    this.showAddBillModal = true;
    this.closeDropdown();
  }

  addNewBill() {
    this.billBeingEdited = null;
    this.showAddBillModal = true;
    this.resetNewBillForm();
  }

  closeModal() {
    this.showAddBillModal = false;
    this.billBeingEdited = null;
    this.resetNewBillForm();
  }

  resetNewBillForm() {
    this.newBill = {
      name: '',
      vendor: '',
      amount: 0,
      paymentDate: '',
      justification: '',
      billPicture: null
    };
  }

  onFileSelected(event: any) {
    const file = event.target.files[0];
    if (file) {
      this.newBill.billPicture = file.name;
    }
  }

  submitBillForReview() {
    if (!this.newBill.name || !this.newBill.vendor || !this.newBill.amount || !this.newBill.paymentDate) {
      this.notification.error('أملاء جميع الحقول المطلوبة');
      return;
    }

    if (this.billBeingEdited) {
      // Update existing
      const index = this.bills.findIndex(b => b.id === this.billBeingEdited!.id);
      if (index !== -1) {
        // adjust total amount
        this.totalAmount = this.totalAmount - this.bills[index].amount + this.newBill.amount;

        this.bills[index] = {
          ...this.bills[index],
          name: this.newBill.name,
          vendor: this.newBill.vendor,
          amount: this.newBill.amount,
          paymentDate: this.newBill.paymentDate,
          justification: this.newBill.justification,
        };
        this.notification.success('تم تحديث الفاتورة بنجاح!');
      }
    } else {
      // Create new
      const newBillEntry: Bill = {
        id: this.bills.length > 0 ? Math.max(...this.bills.map(b => b.id)) + 1 : 1,
        name: this.newBill.name,
        vendor: this.newBill.vendor,
        amount: this.newBill.amount,
        paymentDate: this.newBill.paymentDate,
        justification: this.newBill.justification,
        status: 'Pending',
        icon: '📄'
      };

      this.bills.unshift(newBillEntry);
      this.totalAmount += this.newBill.amount;
      this.notification.success('تم تقديم الفاتورة بنجاح!');
    }

    this.closeModal();
  }

  images: PreviewImage[] = [];
  isDragOver = false;

  onFilesSelected(event: Event) {
    const input = event.target as HTMLInputElement;
    if (!input || !input.files) return;

    const files = Array.from(input.files);
    files.forEach((file) => {
      if (!file.type.startsWith('image/')) return;
      const url = URL.createObjectURL(file);
      this.images.push({ file, url, name: file.name });
    });

    // allow selecting the same file again
    input.value = '';
  }

  onDragOver(event: DragEvent) {
    event.preventDefault();
    this.isDragOver = true;
  }

  onDragLeave(event: DragEvent) {
    event.preventDefault();
    this.isDragOver = false;
  }

  onDrop(event: DragEvent) {
    event.preventDefault();
    this.isDragOver = false;
    if (!event.dataTransfer) return;
    const files = Array.from(event.dataTransfer.files || []);
    files.forEach((file) => {
      if (!file.type.startsWith('image/')) return;
      const url = URL.createObjectURL(file);
      this.images.push({ file, url, name: file.name });
    });
  }

  removeImage(index: number) {
    const img = this.images[index];
    if (img) {
      URL.revokeObjectURL(img.url);
      this.images.splice(index, 1);
    }
  }

  ngOnDestroy(): void {
    this.images.forEach((img) => URL.revokeObjectURL(img.url));
  }
}
