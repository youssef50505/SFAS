import { Component, Input } from '@angular/core';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-request-card',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './request-card.html',
  styleUrls: ['./request-card.css'],
})
export class RequestCard {
  @Input() request: any = {};
}
