import { Component } from '@angular/core';



@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {

  constructor() {
  }

  ngOnInit(): void {
  }

  onItemClick(event) {
    
    var elements = document.getElementsByClassName("active");    
    while(elements.length > 0){
      elements.item(elements.length - 1).classList.remove("active");
    }
    event.srcElement.classList.add("active");
  }
}