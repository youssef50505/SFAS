import { ComponentFixture, TestBed } from '@angular/core/testing';

import { BillMenagment } from './bill-menagment';

describe('BillMenagment', () => {
  let component: BillMenagment;
  let fixture: ComponentFixture<BillMenagment>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [BillMenagment]
    })
    .compileComponents();

    fixture = TestBed.createComponent(BillMenagment);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
