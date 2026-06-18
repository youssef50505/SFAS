import { User } from './user.model';
import { Vendor } from './vendor.model';

export interface Bill {
  id: string;
  title: string;
  vendor: Vendor;
  amount: number;
  tax: number;
  date: string;
  imagePath: string | null;
  description: string;
  status: 'PENDING' | 'APPROVED' | 'REJECTED';
  createdBy?: User;
  reviewedBy?: User | null;
  reviewComments?: string;
  createdAt?: string;
  updatedAt?: string;
}
