import { User } from './user.model';
import { Vendor } from './vendor.model';
import { DocumentStatus } from './status.enum';

export interface Bill {
  id: string;
  title: string;
  vendor: Vendor;
  amount: number;

  date: string;
  imagePath: string | null;
  description: string;
  status: DocumentStatus;
  createdBy?: User;
  reviewedBy?: User | null;
  reviewComments?: string;
  createdAt?: string;
  updatedAt?: string;
}
