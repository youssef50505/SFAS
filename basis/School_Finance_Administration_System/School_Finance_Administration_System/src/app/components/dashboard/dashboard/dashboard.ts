import { Component } from '@angular/core';
import { DashFunds } from "../dash-funds/dash-funds";
import { DashCollection } from "../dash-collection/dash-collection";
import { DashChart } from "../dash-chart/dash-chart";
import { GFooter } from "../../g-footer/g-footer";
import { GNav } from "../../g-nav/g-nav";

@Component({
  selector: 'app-dashboard',
  imports: [DashFunds, DashCollection, DashChart, GFooter, GNav],
  templateUrl: './dashboard.html',
  styleUrl: './dashboard.css',
})
export class Dashboard {

}
