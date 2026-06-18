import { Component, inject } from '@angular/core';
import { Router, RouterModule } from '@angular/router';
import { AuthStore } from '../../core/stores/auth.store';
import { NotificationService } from '../../core/services/notification.service';
import { AuthService } from '../../core/services/auth.service';
import { ThemeService } from '../../core/services/theme.service';
import { LayoutService } from '../../core/services/layout.service';

@Component({
  selector: 'app-header',
  standalone: true,
  imports: [RouterModule],
  templateUrl: './header.component.html',
  styleUrl: './header.component.css'
})
export class HeaderComponent {
  protected readonly authStore = inject(AuthStore);
  protected readonly notificationService = inject(NotificationService);
  protected readonly themeService = inject(ThemeService);
  protected readonly layoutService = inject(LayoutService);
  private readonly authService = inject(AuthService);
  private readonly router = inject(Router);

  toggleTheme(): void {
    this.themeService.toggle();
  }

  navigateToNotifications(): void {
    this.router.navigate(['/notifications']);
  }

  logout(): void {
    this.authService.logout();
    this.router.navigate(['/login']);
  }
}
