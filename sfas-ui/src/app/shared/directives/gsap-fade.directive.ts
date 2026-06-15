import { Directive, ElementRef, OnInit, Input } from '@angular/core';
import gsap from 'gsap';

@Directive({
  selector: '[gsapFade]',
  standalone: true
})
export class GsapFadeDirective implements OnInit {
  @Input() delay: number = 0;
  @Input() yOffset: number = 30;
  @Input() duration: number = 0.6;

  constructor(private el: ElementRef) {}

  ngOnInit() {
    // Initial state
    gsap.set(this.el.nativeElement, {
      opacity: 0,
      y: this.yOffset
    });

    // Animate to final state
    gsap.to(this.el.nativeElement, {
      opacity: 1,
      y: 0,
      duration: this.duration,
      delay: this.delay,
      ease: 'power3.out'
    });
  }
}
