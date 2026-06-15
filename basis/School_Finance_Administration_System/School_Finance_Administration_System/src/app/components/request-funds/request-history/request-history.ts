import { Component, Input } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RequestCard } from '../request-card/request-card';

@Component({
  selector: 'app-request-history',
  standalone: true,
  imports: [CommonModule, RequestCard],
  templateUrl: './request-history.html',
  styleUrls: ['./request-history.css'],
})
export class RequestHistory {
  @Input() requests: any[] = [];

  selectedTab = 'All';
  pages = [1, 2, 3, 4, 5, 6];
  currentPage = 1;

  get filteredRequests() {
    return this.requests.filter((item) =>
      this.selectedTab === 'All' ? true : item.status === this.selectedTab
    );
  }

  selectTab(tab: string) {
    this.selectedTab = tab;
  }
}
