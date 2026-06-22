import { User } from './user.model';
import { DocumentStatus, UrgencyLevel } from './status.enum';

export interface Fund {
  id: string;
  title: string;
  description: string;
  amountOfFund: number;
  urgencyLevel: UrgencyLevel;
  date: string;
  imagePath: string | null;
  status: DocumentStatus;
  createdBy?: User;
  reviewedBy?: User | null;
  reviewComments?: string;
  createdAt?: string;
  updatedAt?: string;
}
