import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ReportsHistory } from './reports-history';

describe('ReportsHistory', () => {
  let component: ReportsHistory;
  let fixture: ComponentFixture<ReportsHistory>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ReportsHistory],
    }).compileComponents();

    fixture = TestBed.createComponent(ReportsHistory);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
