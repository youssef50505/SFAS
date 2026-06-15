import { Component } from '@angular/core';
import { Card } from "../card/card";

@Component({
  selector: 'app-dash-funds',
  imports: [Card],
  templateUrl: './dash-funds.html',
  styleUrl: './dash-funds.css',
})
export class DashFunds {
  approvedFunds = {
    title: 'APPROVED FUNDS',
    value: 1000000
  }

  totalFunds = {
    title: 'TOTAL FUNDS',
    value: 5000000
  }
}
