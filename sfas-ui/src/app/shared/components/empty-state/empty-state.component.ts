import { Component, input } from '@angular/core';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-empty-state',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './empty-state.component.html',
  styleUrls: ['./empty-state.component.css']
})
export class EmptyStateComponent {
  title = input<string>('Inbox Completely Processed');
  description = input<string>('No pending items match criteria state parameters.');
  icon = input<string>('ri-check-line');
}
