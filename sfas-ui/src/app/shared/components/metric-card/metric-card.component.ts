import { Component, input } from '@angular/core';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-metric-card',
  standalone: true,
  imports: [CommonModule],
  template: `
    <div class="metric-card surface">
      <div class="metric-icon" [ngStyle]="{'color': iconColor()}">
        <i [class]="iconClass()"></i>
      </div>
      <div class="metric-info">
        <span class="metric-label">{{ label() }}</span>
        <span class="metric-value" [ngClass]="valueClass()">{{ value() }}</span>
      </div>
    </div>
  `,
  styles: [`
    :host {
      display: block;
      height: 100%;
    }
    .metric-card {
      height: 100%;
      padding: 1.5rem;
      display: flex;
      align-items: center;
      gap: 1.25rem;
      transition: transform var(--transition-normal), box-shadow var(--transition-normal);
      border-radius: var(--radius-lg);
    }
    .metric-card:hover {
      transform: translateY(-5px);
      box-shadow: var(--shadow-lg);
    }
    .metric-icon {
      font-size: 2.5rem;
      width: 65px;
      height: 65px;
      display: flex;
      align-items: center;
      justify-content: center;
      background: rgba(129, 140, 248, 0.08); /* Fallback light background */
      border-radius: var(--radius-md);
    }
    .metric-info {
      display: flex;
      flex-direction: column;
    }
    .metric-label {
      color: var(--text-secondary);
      font-size: 0.9rem;
      font-weight: 600;
      text-transform: uppercase;
      letter-spacing: 0.5px;
      margin-bottom: 0.35rem;
    }
    .metric-value {
      font-family: var(--font-display);
      font-size: 1.5rem;
      font-weight: 800;
      color: var(--text-primary);
    }
    .text-success { color: var(--accent-success); }
    .text-warning { color: var(--accent-warning); }
    .text-danger { color: var(--accent-danger); }
  `]
})
export class MetricCardComponent {
  label = input<string>('');
  value = input<string | number>('');
  iconClass = input<string>('ri-pie-chart-2-line');
  iconColor = input<string>('var(--accent-primary)');
  valueClass = input<string>('');
}
