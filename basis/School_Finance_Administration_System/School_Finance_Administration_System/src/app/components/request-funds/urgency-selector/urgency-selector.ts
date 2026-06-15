import { Component, EventEmitter, Input, Output } from '@angular/core';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-urgency-selector',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './urgency-selector.html',
  styleUrls: ['./urgency-selector.css'],
})
export class UrgencySelector {
  @Input() selected = 'Normal';
  @Output() selectedChange = new EventEmitter<string>();

  options = ['Low', 'Normal', 'High'];

  protected select(option: string) {
    this.selected = option;
    this.selectedChange.emit(option);
  }
}
