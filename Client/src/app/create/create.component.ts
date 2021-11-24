import { Component, OnInit, OnDestroy } from '@angular/core';
import { Validators, FormGroup, FormBuilder } from '@angular/forms';
import { RestApiService } from '../services/rest-api.service';
import { Client } from '../models/client';
import { ActivatedRoute } from "@angular/router";

@Component({
  selector: 'app-create',
  templateUrl: './create.component.html',
  styleUrls: ['./create.component.css']
})
export class CreateComponent implements OnInit, OnDestroy {

  registerForm: FormGroup;
  submitted = false;
  client: Client = new Client();
  clients: Client[];
  Subscription$: any;

  constructor(
    private restApi: RestApiService,
    private fb: FormBuilder,
    private route: ActivatedRoute
  ) { }

  ngOnInit() {

    this.Subscription$ = this.restApi.DateStore.subscribe((data) => {
      this.clients = data; 
      this.clients.forEach(d => {
        if (d.Id.toString() == this.route.snapshot.paramMap.get("id")) {
          this.client = d;
        }
      });
    });

    this.registerForm = this.fb.group({
      idNumber: ['', Validators.required],
      phone: ['', Validators.required],
      firstName: [],
      lastName: [],
      DateOfBirth: [],
      comments: [],
    });

    this.registerForm.patchValue(this.client);
  }

  get registerFormControl() {
    return this.registerForm.controls;
  }

  onSubmit() {
    this.submitted = true;   

    if (this.registerForm.valid) {

      this.client.idNumber = this.registerForm.value.idNumber;
      this.client.phone = this.registerForm.value.phone;
      this.client.firstName = this.registerForm.value.firstName;
      this.client.lastName = this.registerForm.value.lastName;
      this.client.DateOfBirth = this.registerForm.value.DateOfBirth;
      this.client.comments = this.registerForm.value.comments;  
      
      this.restApi.PostClient(this.client).subscribe((data) => {
        if(data == 1)  alert('משתמש חדש נוצר בהצלחה');
        else if(data == 2) alert('עודכנו פרטי משתמש');
     });
    }else{
      alert('יש למלא שדות חובה');
    }

  }

  ngOnDestroy() {

    if (this.Subscription$) {
      this.Subscription$.unsubscribe();
    }

  }
}
