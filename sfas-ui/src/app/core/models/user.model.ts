import { Role } from './role.enum';

export interface User {
  id: string;
  name: string;
  email: string;
  role: Role;
}

export interface AuthResponse {
  token: string;
  userId: string;
  name: string;
  email: string;
  role: Role;
}
