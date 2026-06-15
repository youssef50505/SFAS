import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DashCollection } from './dash-collection';

describe('DashCollection', () => {
  let component: DashCollection;
  let fixture: ComponentFixture<DashCollection>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [DashCollection]
    })
    .compileComponents();

    fixture = TestBed.createComponent(DashCollection);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
