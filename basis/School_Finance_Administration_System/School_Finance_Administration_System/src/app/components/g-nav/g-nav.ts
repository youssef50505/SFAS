import { Component, OnInit } from '@angular/core';
import { RouterModule } from '@angular/router';

@Component({
  selector: 'app-g-nav',
  imports: [RouterModule],
  templateUrl: './g-nav.html',
  styleUrl: './g-nav.css',
})
export class GNav implements OnInit {
  notificationCount: number = 3; // Example notification count
  isDropdownOpen: boolean = false;

  constructor() {}

  ngOnInit(): void {}

  toggleDropdown() {
    this.isDropdownOpen = !this.isDropdownOpen;
    if (this.isDropdownOpen) {
      this.notificationCount = 0; // Clear notifications when viewing
    }
  }

  closeDropdown() {
    this.isDropdownOpen = false;
  }
}
