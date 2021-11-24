import { Component, OnInit, OnDestroy } from '@angular/core';
import { RestApiService } from '../services/rest-api.service';
import { SearchRequest } from '../models/SearchRequest';
import { Client } from '../models/client';

@Component({
  selector: 'app-find',
  templateUrl: './find.component.html',
  styleUrls: ['./find.component.css']
})
export class FindComponent implements OnInit {

  req: SearchRequest = new SearchRequest();
  clients: Client[];

  constructor(private restApi: RestApiService) { }

  ngOnInit(): void {

    // this.restApi.clientsSubject.subscribe((data) => {
    // });
  }


  onChange(deviceValue) {
    this.req.searchParam = deviceValue;
  }

  SearchBtn() {

    if (this.req.searchParam == undefined) {
      alert('יש לבחור פרמטר לחיפוש');
    }
    else if (this.req.searchValue === '' 
    || this.req.searchValue === undefined ) {
      alert('הקלד מילות חיפוש');
    }
    else {
      
      this.restApi.getFilteredClients(this.req).subscribe((data) => {
        this.clients = data
        this.restApi.DateStore.next(this.clients);        
      });

    }
  }

}
