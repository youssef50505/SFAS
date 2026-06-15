import { ComponentFixture, TestBed } from '@angular/core/testing';

import { FundsRequestForm } from './funds-request-form';

describe('FundsRequestForm', () => {
  let component: FundsRequestForm;
  let fixture: ComponentFixture<FundsRequestForm>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [FundsRequestForm],
    }).compileComponents();

    fixture = TestBed.createComponent(FundsRequestForm);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
