import { Injectable, signal, computed, effect } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class ThemeService {
  private readonly STORAGE_KEY = 'sfas_theme_preference';
  private darkModeSignal = signal<boolean>(false);

  public readonly isDark = computed(() => this.darkModeSignal());
  public readonly themeLabel = computed(() => this.darkModeSignal() ? 'Dark' : 'Light');

  constructor() {
    this.loadInitialTheme();

    effect(() => {
      const isDark = this.darkModeSignal();
      if (isDark) {
        document.body.classList.add('dark-theme');
      } else {
        document.body.classList.remove('dark-theme');
      }
      localStorage.setItem(this.STORAGE_KEY, isDark ? 'dark' : 'light');
    });
  }

  private loadInitialTheme(): void {
    const stored = localStorage.getItem(this.STORAGE_KEY);
    if (stored) {
      this.darkModeSignal.set(stored === 'dark');
    } else {
      const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
      this.darkModeSignal.set(prefersDark);
    }
  }

  toggle(): void {
    this.darkModeSignal.update(v => !v);
  }

  setTheme(mode: 'light' | 'dark'): void {
    this.darkModeSignal.set(mode === 'dark');
  }
}
