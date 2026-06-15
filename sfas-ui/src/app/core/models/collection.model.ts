import { User } from './user.model';

export interface Collection {
  id: string;
  date: string;
  type: 'DAILY' | 'WEEKLY' | 'MONTHLY' | 'ANNUAL';
  amount: number;
  createdBy?: User;
  createdAt?: string;
  updatedAt?: string;
}
