import { Component, inject } from '@angular/core';
import { NotificationService } from '../../core/services/notification.service';
import { PageHeaderComponent } from '../../shared/components/page-header/page-header.component';
import { GsapFadeDirective } from '../../shared/directives/gsap-fade.directive';
import { EmptyStateComponent } from '../../shared/components/empty-state/empty-state.component';

@Component({
  selector: 'app-notifications',
  standalone: true,
  imports: [PageHeaderComponent, GsapFadeDirective, EmptyStateComponent],
  templateUrl: './notifications.component.html',
  styleUrl: './notifications.component.css'
})
export class NotificationsComponent {
  notificationService = inject(NotificationService);

  getRecentAlerts() {
    return this.notificationService.notifications();
  }

  clearAll() {
    this.notificationService.clearNotifications();
  }
}
