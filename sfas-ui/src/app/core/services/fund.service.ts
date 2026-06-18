import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Fund } from '../models/fund.model';
import { environment } from '../../../environments/environment';

@Injectable({
  providedIn: 'root'
})
export class FundService {
  private http = inject(HttpClient);
  private baseUrl = environment.apiUrl + '/api/v1/funds';

  getAllFunds(): Observable<Fund[]> {
    return this.http.get<Fund[]>(this.baseUrl);
  }

  createFund(fund: Partial<Fund>): Observable<Fund> {
    return this.http.post<Fund>(this.baseUrl, fund);
  }

  updateFundStatus(id: string, status: 'APPROVED' | 'REJECTED' | 'PENDING', comments?: string): Observable<Fund> {
    return this.http.patch<Fund>(`${this.baseUrl}/${id}/status`, { status, comments });
  }
}
