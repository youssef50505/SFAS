import { User } from './user.model';

export interface Vendor {
  id: string;
  name: string;
  contactEmail: string;
  phoneNumber: string;
  taxId: string;
  address: string;
  createdBy?: User;
  createdAt?: string;
  updatedAt?: string;
}
