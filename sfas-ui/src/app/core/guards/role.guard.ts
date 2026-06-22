import { CanActivateFn, Router } from '@angular/router';
import { inject } from '@angular/core';
import { AuthStore } from '../stores/auth.store';
import { Role } from '../models/role.enum';

export const roleGuard: CanActivateFn = (route, state) => {
  const authStore = inject(AuthStore);
  const router = inject(Router);
  const expectedRoles: Array<string> = route.data['roles'] || [];

  const currentUser = authStore.currentUser();

  if (!authStore.isAuthenticated() || !currentUser) {
    return router.createUrlTree(['/login']);
  }

  if (expectedRoles.includes(currentUser.role)) {
    return true;
  }

  // Redirect based on role if unauthorized for this route
  if (currentUser.role === Role.ADMIN) {
    return router.createUrlTree(['/admin/dashboard']);
  } else {
    return router.createUrlTree(['/finance/dashboard']);
  }
};
