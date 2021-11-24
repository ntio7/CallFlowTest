import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Subject, BehaviorSubject, Observable, throwError } from 'rxjs';
import { catchError, take } from 'rxjs/operators';
import { Client } from '../models/client';
import { SearchRequest } from '../models/SearchRequest';
import { environment } from 'src/environments/environment';

const INIT_DATA = [];

@Injectable({
  providedIn: 'root'
})
export class RestApiService {

  public DateStore = new BehaviorSubject(INIT_DATA);
  data$: Observable<Client[]> = this.DateStore.asObservable();

  constructor(
    private http: HttpClient,
    public clientsSubject: Subject<Client[]>) {

  }

  ngOnInit() {
  }


  getTitle(): Observable<any> {
    return this.http.get<any>('../../assets/data.json')
      .pipe(
        catchError(this.handleError)
      )
  }

  PostClient(client: Client): Observable<any> {

    return this.http.post<any>(environment.BASE_URL + '/api/Client/PostClient', client)
      .pipe(
        catchError(this.handleError)
      )
  }

  getFilteredClients(req: SearchRequest): Observable<any> {

    return this.http.post<any>(environment.BASE_URL + '/api/Client/PostFilteredClients', req)
      .pipe(
        catchError(this.handleError)
      )
  }


  updateMovies(c: any) {
    // Post to file 
    console.log(c)
  }

  // Error handling
  handleError(error: any) {
    let errorMessage = '';
    if (error.error instanceof ErrorEvent) {
      // Get client-side error
      errorMessage = error.error.message;
    } else {
      // Get server-side error
      errorMessage = `Error Code: ${error.status}\nMessage: ${error.message}`;
    }
    window.alert(errorMessage);
    return throwError(errorMessage);
  }
}
