import { Component } from '@angular/core';
import { Card } from "../card/card";

@Component({
  selector: 'app-dash-collection',
  imports: [Card],
  templateUrl: './dash-collection.html',
  styleUrl: './dash-collection.css',
})
export class DashCollection {

  totalCT = {
    title: 'TOTAL COLLECTION(TODAY)',
    value: 1500
  }
  totalCW = {
    title: 'TOTAL COLLECTION(WEEKLY)',
    value: 5000
  }
  totalCM = {
    title: 'TOTAL COLLECTION(MONTHLY)',
    value: 20000
  }
  totalCA = {
    title: 'TOTAL COLLECTION(ANNUALLY)',
    value: 100000
  }
}
