export interface User {
  id: string;
  name: string;
  email: string;
  role: 'ADMIN' | 'FINANCE_OFFICER';
}

export interface AuthResponse {
  token: string;
  userId: string;
  name: string;
  email: string;
  role: 'ADMIN' | 'FINANCE_OFFICER';
}
