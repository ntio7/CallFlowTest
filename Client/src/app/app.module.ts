import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { AppRoutingModule } from './app-routing.module';
import {ReactiveFormsModule } from '@angular/forms';
import {NgbModule} from '@ng-bootstrap/ng-bootstrap';
import { BsDropdownModule } from 'ngx-bootstrap/dropdown';
import { TooltipModule } from 'ngx-bootstrap/tooltip';
import { ModalModule } from 'ngx-bootstrap/modal';
import { FormsModule } from '@angular/forms';
import { Injectable } from '@angular/core';

// HttpClient module for RESTful API
import { HttpClientModule } from '@angular/common/http';
import { RestApiService } from './services/rest-api.service';

// Components
import { AppComponent } from './app.component';
import { HomeComponent } from './home/home.component';
import { FindComponent } from './find/find.component';
import { CreateComponent } from './create/create.component';

import { Subject } from 'rxjs';
import { BehaviorSubject } from 'rxjs/internal/BehaviorSubject';


@NgModule({
  declarations: [
    AppComponent,
    CreateComponent,
    HomeComponent,
    FindComponent,
    
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    ReactiveFormsModule,
    NgbModule,   
    BrowserModule,
    FormsModule,

    BsDropdownModule.forRoot(),
    TooltipModule.forRoot(),
    ModalModule.forRoot()
  ],
  providers: [
    RestApiService,
    Subject,
    Injectable
    
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
