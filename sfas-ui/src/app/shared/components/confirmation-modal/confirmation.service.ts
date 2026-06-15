import { Injectable, signal } from '@angular/core';
import { Subject } from 'rxjs';

export interface ConfirmationConfig {
  title: string;
  message: string;
  confirmText?: string;
  cancelText?: string;
  isDanger?: boolean;
}

@Injectable({
  providedIn: 'root'
})
export class ConfirmationService {
  private configSignal = signal<ConfirmationConfig | null>(null);
  private responseSubject = new Subject<boolean>();

  config = this.configSignal.asReadonly();

  confirm(config: ConfirmationConfig): Promise<boolean> {
    this.configSignal.set(config);
    return new Promise((resolve) => {
      const sub = this.responseSubject.subscribe((res) => {
        resolve(res);
        sub.unsubscribe();
        this.configSignal.set(null);
      });
    });
  }

  respond(result: boolean) {
    this.responseSubject.next(result);
  }
}
