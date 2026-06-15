import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ReportTypeSelector } from './report-type-selector';

describe('ReportTypeSelector', () => {
  let component: ReportTypeSelector;
  let fixture: ComponentFixture<ReportTypeSelector>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ReportTypeSelector],
    }).compileComponents();

    fixture = TestBed.createComponent(ReportTypeSelector);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
