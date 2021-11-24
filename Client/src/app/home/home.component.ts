import { Component, OnInit } from '@angular/core';
import { RestApiService } from '../services/rest-api.service';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {

  title = '';

  constructor(private restApi: RestApiService) { }

   
  ngOnInit() {

    this.restApi.getTitle().subscribe((data) => {
      this.title = data.title;
    });
  } 

}
