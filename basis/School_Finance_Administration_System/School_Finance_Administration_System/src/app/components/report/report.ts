import { Component } from '@angular/core';
import { NewReportForm } from "./new-report-form/new-report-form";
import { GNav } from "../g-nav/g-nav";
import { GFooter } from "../g-footer/g-footer";

@Component({
  selector: 'app-report',
  imports: [NewReportForm, GNav, GFooter],
  templateUrl: './report.html',
  styleUrl: './report.css',
})
export class Report {

}
