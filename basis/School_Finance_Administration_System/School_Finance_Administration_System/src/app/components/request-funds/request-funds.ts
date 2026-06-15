import { Component, signal } from '@angular/core';
import { GNav } from "../g-nav/g-nav";
import { GFooter } from "../g-footer/g-footer";
import { FundsRequestForm } from "./funds-request-form/funds-request-form";
import { RequestHistory } from "./request-history/request-history";

@Component({
  selector: 'app-request-funds',
  imports: [GNav, GFooter, FundsRequestForm, RequestHistory],
  templateUrl: './request-funds.html',
  styleUrl: './request-funds.css',
})
export class RequestFunds {
  protected readonly requests = signal([
    { }
  ]);

  protected addRequest(request: any) {
    const nextId = `REQ-2026-${(this.requests().length + 1).toString().padStart(3, '0')}`;
    this.requests.update((all) => [
      {
        ...request,
        id: nextId,
        status: 'Pending',
        amount: request.amount.replace(/[^0-9.]/g, '') || '0.00',
        date: new Date().toLocaleDateString('en-US', { month: 'short', day: '2-digit', year: 'numeric' })
      },
      ...all
    ]);
  }
}
