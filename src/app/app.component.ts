import { state, style, transition, trigger, useAnimation } from '@angular/animations';
import { Component } from '@angular/core';
import { bounce, flip } from 'ng-animate';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css'],
  animations: [
    trigger('bounce', [
      state('in', style({ transform: 'translateX(10)' })),
      state('out', style({ transform: 'translateX(0)' })),
      transition('* => in', useAnimation(flip)),
      transition(':enter', useAnimation(bounce)),
      transition(':leave', useAnimation(bounce))
    ])
  ]
})
export class AppComponent {
  imgState: String = '';
  public logoState(elemState: String) {
    this.imgState = elemState;
  }
}
