import { ComponentFixture, TestBed } from '@angular/core/testing';

import { GNav } from './g-nav';

describe('GNav', () => {
  let component: GNav;
  let fixture: ComponentFixture<GNav>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [GNav]
    })
    .compileComponents();

    fixture = TestBed.createComponent(GNav);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
