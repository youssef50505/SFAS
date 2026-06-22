import { User } from './user.model';
import { ReportType } from './status.enum';

export interface Report {
  id: string;
  date: string;
  title: string;
  description: string;
  typeOfReport: ReportType;
  createdBy?: User;
  createdAt?: string;
  updatedAt?: string;
}
