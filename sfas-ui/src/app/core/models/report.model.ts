import { User } from './user.model';

export interface Report {
  id: string;
  date: string;
  title: string;
  description: string;
  typeOfReport: 'EMAIL' | 'IN_APP';
  createdBy?: User;
  createdAt?: string;
  updatedAt?: string;
}
