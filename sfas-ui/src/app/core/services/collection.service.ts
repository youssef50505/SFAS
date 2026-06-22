import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { CollectionMetrics } from '../models/collection.model';
import { environment } from '../../../environments/environment';

@Injectable({
  providedIn: 'root'
})
export class CollectionService {
  private http = inject(HttpClient);
  private baseUrl = environment.apiUrl + '/api/v1/collections/metrics';

  getCollectionMetrics(): Observable<CollectionMetrics> {
    return this.http.get<CollectionMetrics>(this.baseUrl);
  }
}
