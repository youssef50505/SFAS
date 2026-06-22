import { HttpInterceptorFn, HttpErrorResponse } from '@angular/common/http';
import { inject } from '@angular/core';
import { catchError, throwError } from 'rxjs';
import { ToastService } from '../../shared/components/toast/toast.service';
import { AuthService } from '../services/auth.service';
import { Router } from '@angular/router';

export const errorInterceptor: HttpInterceptorFn = (req, next) => {
  const toast = inject(ToastService);
  const authService = inject(AuthService);
  const router = inject(Router);

  return next(req).pipe(
    catchError((error: HttpErrorResponse) => {
      // Don't show toast for login endpoint 401s, let the component handle it
      if (req.url.includes('/login') && error.status === 401) {
        return throwError(() => error);
      }

      if (error.status === 401) {
        authService.logout();
        toast.error('Session expired or unauthorized. Please log in again.');
        router.navigate(['/login']);
      } else if (error.status === 403) {
        toast.error('You do not have permission to perform this action.');
      } else if (error.status === 400) {
        if (error.error?.detail) {
          toast.error(error.error.detail);
        } else {
          toast.error('Bad request. Please check your input.');
        }
      } else if (error.status >= 500) {
        toast.error('Server error. Please try again later.');
      } else if (error.status === 0) {
        toast.error('Network error. Please check your connection.');
      }
      
      return throwError(() => error);
    })
  );
};
