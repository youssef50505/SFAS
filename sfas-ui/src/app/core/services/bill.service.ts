import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Bill } from '../models/bill.model';
import { environment } from '../../../environments/environment';

@Injectable({
  providedIn: 'root'
})
export class BillService {
  private http = inject(HttpClient);
  private baseUrl = environment.apiUrl + '/api/v1/bills';

  getAllBills(): Observable<Bill[]> {
    return this.http.get<Bill[]>(this.baseUrl);
  }

  getBillById(id: string): Observable<Bill> {
    return this.http.get<Bill>(`${this.baseUrl}/${id}`);
  }

  createBill(bill: Partial<Bill>): Observable<Bill> {
    return this.http.post<Bill>(this.baseUrl, bill);
  }

  updateBillStatus(id: string, status: 'APPROVED' | 'REJECTED'): Observable<Bill> {
    return this.http.patch<Bill>(`${this.baseUrl}/${id}/status`, { status });
  }
}
