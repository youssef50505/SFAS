import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Report } from '../models/report.model';
import { environment } from '../../../environments/environment';

@Injectable({
  providedIn: 'root'
})
export class ReportService {
  private http = inject(HttpClient);
  private baseUrl = environment.apiUrl + '/api/v1/reports';

  getAllReports(): Observable<Report[]> {
    return this.http.get<Report[]>(this.baseUrl);
  }

  createReport(report: Partial<Report>): Observable<Report> {
    return this.http.post<Report>(this.baseUrl, report);
  }
}
