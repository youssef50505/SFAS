import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DashFunds } from './dash-funds';

describe('DashFunds', () => {
  let component: DashFunds;
  let fixture: ComponentFixture<DashFunds>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [DashFunds]
    })
    .compileComponents();

    fixture = TestBed.createComponent(DashFunds);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
