import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormBuilder, FormGroup, Validators, ReactiveFormsModule } from '@angular/forms';
import { NotificationService } from '../../services/notification';
import { Router } from '@angular/router';

interface loginData{
  
}

@Component({
  selector: 'app-login-form', imports: [
    CommonModule,
    ReactiveFormsModule,
  ],
  templateUrl: './login-form.html',
  styleUrl: './login-form.css',
})
export class LoginForm {

  loginForm: FormGroup;
  hidePassword = true;
  roles = ['Administration', 'Finance Officer'];

  constructor(private fb: FormBuilder, private notification: NotificationService, private router: Router) {
    this.loginForm = this.fb.group({
      email: ['', [Validators.required, Validators.email]],
      password: ['', [Validators.required, Validators.minLength(6)]],
      role: ['Administration', Validators.required]
    });
  }

  onSubmit() {
    if (this.loginForm.valid) {

      this.notification.success('تم تسجيل دخولك بنجاح !');

      setTimeout(() => {
        this.router.navigate(['/dashboard']);
      }, 500);

    } else {

      this.notification.error('Please fill all required fields');

    }
  }
}