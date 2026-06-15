import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DashChart } from './dash-chart';

describe('DashChart', () => {
  let component: DashChart;
  let fixture: ComponentFixture<DashChart>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [DashChart]
    })
    .compileComponents();

    fixture = TestBed.createComponent(DashChart);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
