import { Component, inject, OnInit, DestroyRef } from '@angular/core';
import { takeUntilDestroyed } from '@angular/core/rxjs-interop';
import { CurrencyPipe } from '@angular/common';
import { AuthStore } from '../../core/stores/auth.store';
import { PageHeaderComponent } from '../../shared/components/page-header/page-header.component';
import { GsapFadeDirective } from '../../shared/directives/gsap-fade.directive';
import { CollectionStore } from './store/collection.store';
import { MetricCardComponent } from '../../shared/components/metric-card/metric-card.component';

@Component({
  selector: 'app-collections',
  standalone: true,
  imports: [CurrencyPipe, PageHeaderComponent, GsapFadeDirective, MetricCardComponent],
  templateUrl: './collections.component.html',
  styleUrl: './collections.component.css'
})
export class CollectionsComponent implements OnInit {
  store = inject(CollectionStore);
  authStore = inject(AuthStore);
  private destroyRef = inject(DestroyRef);

  ngOnInit() {
    this.store.loadMetrics().pipe(takeUntilDestroyed(this.destroyRef)).subscribe();
  }
}
