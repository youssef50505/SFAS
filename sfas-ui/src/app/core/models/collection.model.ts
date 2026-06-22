import { User } from './user.model';
import { CollectionType } from './status.enum';

export interface Collection {
  id: string;
  date: string;
  type: CollectionType;
  amount: number;
  createdBy?: User;
  createdAt?: string;
  updatedAt?: string;
}
