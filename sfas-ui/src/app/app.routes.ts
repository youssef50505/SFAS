import { Routes } from '@angular/router';
import { authGuard } from './core/guards/auth.guard';
import { roleGuard } from './core/guards/role.guard';
import { inject } from '@angular/core';
import { AuthStore } from './core/stores/auth.store';

export const routes: Routes = [
  { 
    path: 'login', 
    loadComponent: () => import('./features/auth/login/login.component').then(m => m.LoginComponent) 
  },
  {
    path: '',
    loadComponent: () => import('./layout/layout.component').then(m => m.LayoutComponent),
    canActivate: [authGuard],
    children: [
      { 
        path: '', 
        pathMatch: 'full',
        redirectTo: () => {
          const authStore = inject(AuthStore);
          const role = authStore.currentUser()?.role;
          return role === 'FINANCE_OFFICER' ? 'finance/dashboard' : 'admin/dashboard';
        }
      },
      { 
        path: 'admin/dashboard', 
        loadComponent: () => import('./features/admin-dashboard/admin-dashboard.component').then(m => m.AdminDashboardComponent),
        canActivate: [roleGuard],
        data: { roles: ['ADMIN'] }
      },
      { 
        path: 'finance/dashboard', 
        loadComponent: () => import('./features/finance-dashboard/finance-dashboard.component').then(m => m.FinanceDashboardComponent),
        canActivate: [roleGuard],
        data: { roles: ['FINANCE_OFFICER'] }
      },
      { 
        path: 'vendors', 
        loadComponent: () => import('./features/vendors/vendors.component').then(m => m.VendorsComponent) 
      },
      { 
        path: 'bills', 
        loadComponent: () => import('./features/bills/bills.component').then(m => m.BillsComponent) 
      },
      { 
        path: 'funds', 
        loadComponent: () => import('./features/funds/funds.component').then(m => m.FundsComponent) 
      },
      { 
        path: 'collections', 
        loadComponent: () => import('./features/collections/collections.component').then(m => m.CollectionsComponent) 
      },
      { 
        path: 'reports', 
        loadComponent: () => import('./features/reports/reports.component').then(m => m.ReportsComponent) 
      },
      {
        path: 'notifications',
        loadComponent: () => import('./features/notifications/notifications.component').then(m => m.NotificationsComponent)
      }
    ]
  },
  { path: '**', redirectTo: 'login' }
];
