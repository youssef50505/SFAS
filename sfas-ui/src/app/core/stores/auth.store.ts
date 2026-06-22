import { Injectable, signal, computed } from '@angular/core';
import { User } from '../models/user.model';
import { Role } from '../models/role.enum';

@Injectable({
  providedIn: 'root'
})
export class AuthStore {
  // Using signals for reactive state management
  private userSignal = signal<User | null>(null);
  private tokenSignal = signal<string | null>(null);

  // Computed signals
  public readonly currentUser = computed(() => this.userSignal());
  public readonly currentToken = computed(() => this.tokenSignal());
  public readonly isAuthenticated = computed(() => !!this.tokenSignal());
  public readonly isAdmin = computed(() => this.userSignal()?.role === Role.ADMIN);
  public readonly isFinanceOfficer = computed(() => this.userSignal()?.role === Role.FINANCE_OFFICER);

  constructor() {
    this.loadInitialState();
  }

  private loadInitialState() {
    const token = localStorage.getItem('jwt_token');
    const userStr = localStorage.getItem('user_data');
    if (token && userStr) {
      this.tokenSignal.set(token);
      this.userSignal.set(JSON.parse(userStr));
    }
  }

  public setAuth(token: string, user: User) {
    localStorage.setItem('jwt_token', token);
    localStorage.setItem('user_data', JSON.stringify(user));
    this.tokenSignal.set(token);
    this.userSignal.set(user);
  }

  public clearAuth() {
    localStorage.removeItem('jwt_token');
    localStorage.removeItem('user_data');
    this.tokenSignal.set(null);
    this.userSignal.set(null);
  }
}
