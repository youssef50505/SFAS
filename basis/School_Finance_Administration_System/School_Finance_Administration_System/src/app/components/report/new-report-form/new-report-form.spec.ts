import { ComponentFixture, TestBed } from '@angular/core/testing';

import { NewReportForm } from './new-report-form';

describe('NewReportForm', () => {
  let component: NewReportForm;
  let fixture: ComponentFixture<NewReportForm>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [NewReportForm],
    }).compileComponents();

    fixture = TestBed.createComponent(NewReportForm);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
