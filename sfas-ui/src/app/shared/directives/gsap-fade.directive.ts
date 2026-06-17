import { Directive, ElementRef, AfterViewInit, input, inject } from '@angular/core';
import gsap from 'gsap';

@Directive({
  selector: '[gsapFade]',
  standalone: true
})
export class GsapFadeDirective implements AfterViewInit {
  delay = input<number>(0);
  yOffset = input<number>(30);
  duration = input<number>(0.6);

  private el = inject(ElementRef);

  ngAfterViewInit() {
    // Initial state
    gsap.set(this.el.nativeElement, {
      opacity: 0,
      y: this.yOffset(),
      willChange: 'transform, opacity'
    });

    // Animate to final state
    gsap.to(this.el.nativeElement, {
      opacity: 1,
      y: 0,
      duration: this.duration(),
      delay: this.delay(),
      ease: 'power3.out',
      clearProps: 'willChange'
    });
  }
}
