import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { tap, Observable } from 'rxjs';
import { AuthStore } from '../stores/auth.store';
import { AuthResponse } from '../models/user.model';
import { environment } from '../../../environments/environment';

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  private http = inject(HttpClient);
  private authStore = inject(AuthStore);
  private baseUrl = environment.apiUrl + '/api/v1/auth';

  login(email: string, password: string): Observable<AuthResponse> {
    return this.http.post<AuthResponse>(`${this.baseUrl}/login`, { email, password }).pipe(
      tap(response => {
        const user = {
          id: response.userId,
          name: response.name,
          email: response.email,
          role: response.role
        };
        this.authStore.setAuth(response.token, user);
      })
    );
  }

  logout(): void {
    this.authStore.clearAuth();
  }
}
