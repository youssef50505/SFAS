import { Component, EventEmitter, Output } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { FileUpload } from '../file-upload/file-upload';
import { UrgencySelector } from '../urgency-selector/urgency-selector';

@Component({
  selector: 'app-funds-request-form',
  standalone: true,
  imports: [CommonModule, FormsModule, UrgencySelector, FileUpload],
  templateUrl: './funds-request-form.html',
  styleUrls: ['./funds-request-form.css'],
})
export class FundsRequestForm {
  @Output() submitRequest = new EventEmitter<any>();

  requestTitle = '';
  amount = '';
  recipient = '';
  department = '';
  description = '';
  urgency = 'Normal';
  attachment = '';

  protected submitForm() {
    const payload = {
      title: this.requestTitle || 'New funding request',
      amount: this.amount || '$0',
      recipient: this.recipient || 'General team',
      department: this.department || 'Operations',
      description: this.description || 'No additional notes provided.',
      urgency: this.urgency,
      attachment: this.attachment,
      status: 'Pending',
      date: new Date().toLocaleDateString('en-US')
    };

    this.submitRequest.emit(payload);
    this.resetForm();
  }

  protected resetForm() {
    this.requestTitle = '';
    this.amount = '';
    this.recipient = '';
    this.department = '';
    this.description = '';
    this.urgency = 'Normal';
    this.attachment = '';
  }

  protected updateAttachment(fileName: string) {
    this.attachment = fileName;
  }
}
