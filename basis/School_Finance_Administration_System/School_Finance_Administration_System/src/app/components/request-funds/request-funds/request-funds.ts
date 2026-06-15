import { Component, Input } from '@angular/core';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-request-funds',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './request-funds.html',
  styleUrls: ['./request-funds.css'],
})
export class RequestFunds {
  @Input() requests: any[] = [];

  get totalRequests() {
    return this.requests?.length || 0;
  }

  get approvedRequests() {
    return this.requests?.filter((request) => request.status === 'Approved').length || 0;
  }

  get pendingRequests() {
    return this.requests?.filter((request) => request.status === 'Pending').length || 0;
  }
}
