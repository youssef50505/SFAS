import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Collection } from '../models/collection.model';
import { environment } from '../../../environments/environment';

@Injectable({
  providedIn: 'root'
})
export class CollectionService {
  private http = inject(HttpClient);
  private baseUrl = environment.apiUrl + '/api/v1/collections';

  getAllCollections(): Observable<Collection[]> {
    return this.http.get<Collection[]>(this.baseUrl);
  }

  createCollection(collection: Partial<Collection>): Observable<Collection> {
    return this.http.post<Collection>(this.baseUrl, collection);
  }
}
