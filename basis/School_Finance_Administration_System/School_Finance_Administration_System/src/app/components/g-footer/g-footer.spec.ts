import { ComponentFixture, TestBed } from '@angular/core/testing';

import { GFooter } from './g-footer';

describe('GFooter', () => {
  let component: GFooter;
  let fixture: ComponentFixture<GFooter>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [GFooter]
    })
    .compileComponents();

    fixture = TestBed.createComponent(GFooter);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
