import { User } from './user.model';

export interface Fund {
  id: string;
  title: string;
  description: string;
  amountOfFund: number;
  urgencyLevel: 'LOW' | 'MEDIUM' | 'HIGH' | 'CRITICAL';
  date: string;
  imagePath: string | null;
  status: 'PENDING' | 'APPROVED' | 'REJECTED';
  createdBy?: User;
  reviewedBy?: User | null;
  createdAt?: string;
  updatedAt?: string;
}
