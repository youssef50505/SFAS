import { ComponentFixture, TestBed } from '@angular/core/testing';

import { RequestFunds } from './request-funds';

describe('RequestFunds', () => {
  let component: RequestFunds;
  let fixture: ComponentFixture<RequestFunds>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [RequestFunds],
    }).compileComponents();

    fixture = TestBed.createComponent(RequestFunds);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
