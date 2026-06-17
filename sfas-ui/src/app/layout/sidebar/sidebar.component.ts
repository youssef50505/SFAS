import { Component, inject } from '@angular/core';
import { RouterModule, Router } from '@angular/router';
import { AuthStore } from '../../core/stores/auth.store';
import { AuthService } from '../../core/services/auth.service';
import { LayoutService } from '../../core/services/layout.service';

@Component({
  selector: 'app-sidebar',
  standalone: true,
  imports: [RouterModule],
  templateUrl: './sidebar.component.html',
  styleUrls: ['./sidebar.component.css']
})
export class SidebarComponent {
  protected readonly authStore = inject(AuthStore);
  protected readonly layoutService = inject(LayoutService);
  private readonly authService = inject(AuthService);
  private readonly router = inject(Router);

  get role(): string | undefined {
    return this.authStore.currentUser()?.role;
  }

  logout(): void {
    this.authService.logout();
    this.router.navigate(['/login']);
  }
}
