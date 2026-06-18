import { Component, EventEmitter, Output, input } from '@angular/core';
import { ReactiveFormsModule, FormBuilder, Validators, FormGroup } from '@angular/forms';
import { CurrencyPipe, DatePipe, NgClass, UpperCasePipe } from '@angular/common';
import { GsapFadeDirective } from '../../directives/gsap-fade.directive';

export interface ReviewModalConfig {
  type: 'fund' | 'bill';
  id: string;
  submittedDate: string;
  title: string;
  grossAmount: number;
  details: { label: string, value: string }[];
  description: string;
  documentName?: string | null;
  status: string;
  comments?: string;
  isReadOnly: boolean;
}

@Component({
  selector: 'app-review-modal',
  standalone: true,
  imports: [ReactiveFormsModule, CurrencyPipe, DatePipe, NgClass, GsapFadeDirective, UpperCasePipe],
  templateUrl: './review-modal.component.html',
  styleUrl: './review-modal.component.css'
})
export class ReviewModalComponent {
  config = input.required<ReviewModalConfig>();
  
  @Output() close = new EventEmitter<void>();
  @Output() approve = new EventEmitter<string>();
  @Output() reject = new EventEmitter<string>();
  @Output() pending = new EventEmitter<string>();

  reviewForm: FormGroup;

  constructor(private fb: FormBuilder) {
    this.reviewForm = this.fb.group({
      comments: ['', [Validators.maxLength(500)]]
    });
  }

  onClose() {
    this.close.emit();
  }

  onApprove() {
    if (this.reviewForm.valid) {
      this.approve.emit(this.reviewForm.value.comments);
    }
  }

  onReject() {
    if (this.reviewForm.valid) {
      this.reject.emit(this.reviewForm.value.comments);
    }
  }

  onPending() {
    if (this.reviewForm.valid) {
      this.pending.emit(this.reviewForm.value.comments);
    }
  }
}
