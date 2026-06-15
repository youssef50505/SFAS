import { Injectable, inject, signal, computed, DestroyRef } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, tap, timer, switchMap, catchError, of } from 'rxjs';
import { takeUntilDestroyed } from '@angular/core/rxjs-interop';
import { environment } from '../../../environments/environment';
import { AuthStore } from '../stores/auth.store';

@Injectable({
  providedIn: 'root'
})
export class NotificationService {
  private http = inject(HttpClient);
  private authStore = inject(AuthStore);
  private baseUrl = environment.apiUrl + '/api/v1/notifications';

  private notificationsSignal = signal<string[]>([]);
  public readonly notifications = computed(() => this.notificationsSignal());
  public readonly unreadCount = computed(() => this.notificationsSignal().length);

  constructor() {
    // Poll every 30 seconds if authenticated
    timer(0, 30000).pipe(
      switchMap(() => {
        if (this.authStore.isAuthenticated()) {
          return this.fetchNotifications();
        }
        return of([]);
      })
    ).pipe(takeUntilDestroyed()).subscribe();
  }

  fetchNotifications(): Observable<string[]> {
    return this.http.get<string[]>(this.baseUrl).pipe(
      tap(data => this.notificationsSignal.set(data)),
      catchError(() => of([]))
    );
  }

  clearNotifications(): void {
    this.notificationsSignal.set([]);
  }
}
