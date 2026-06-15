import { Component, input } from '@angular/core';

@Component({
  selector: 'app-page-header',
  standalone: true,
  template: `
    <div class="page-header">
      <div class="header-text">
        <h1>{{ title() }}</h1>
        @if (subtitle()) {
          <p>{{ subtitle() }}</p>
        }
      </div>
      <div class="header-actions">
        <ng-content></ng-content>
      </div>
    </div>
  `,
  styles: [`
    .page-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 2rem;
    }
    .header-text h1 {
      font-size: 2.2rem;
      font-weight: 700;
      color: var(--text-primary);
      margin-bottom: 0.25rem;
    }
    .header-text p {
      color: var(--text-secondary);
      font-size: 0.95rem;
    }
    .header-actions {
      display: flex;
      gap: 1rem;
    }
  `]
})
export class PageHeaderComponent {
  title = input<string>('');
  subtitle = input<string | undefined>();
}
