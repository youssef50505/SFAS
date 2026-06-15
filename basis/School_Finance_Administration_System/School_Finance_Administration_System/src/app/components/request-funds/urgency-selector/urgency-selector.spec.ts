import { ComponentFixture, TestBed } from '@angular/core/testing';

import { UrgencySelector } from './urgency-selector';

describe('UrgencySelector', () => {
  let component: UrgencySelector;
  let fixture: ComponentFixture<UrgencySelector>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [UrgencySelector],
    }).compileComponents();

    fixture = TestBed.createComponent(UrgencySelector);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
