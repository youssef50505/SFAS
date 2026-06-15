import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Vendor } from '../models/vendor.model';
import { environment } from '../../../environments/environment';

@Injectable({
  providedIn: 'root'
})
export class VendorService {
  private http = inject(HttpClient);
  private baseUrl = environment.apiUrl + '/api/v1/vendors';

  getAllVendors(): Observable<Vendor[]> {
    return this.http.get<Vendor[]>(this.baseUrl);
  }

  getVendorById(id: string): Observable<Vendor> {
    return this.http.get<Vendor>(`${this.baseUrl}/${id}`);
  }

  createVendor(vendor: Partial<Vendor>): Observable<Vendor> {
    return this.http.post<Vendor>(this.baseUrl, vendor);
  }

  updateVendor(id: string, vendor: Partial<Vendor>): Observable<Vendor> {
    return this.http.put<Vendor>(`${this.baseUrl}/${id}`, vendor);
  }

  deleteVendor(id: string): Observable<void> {
    return this.http.delete<void>(`${this.baseUrl}/${id}`);
  }
}
