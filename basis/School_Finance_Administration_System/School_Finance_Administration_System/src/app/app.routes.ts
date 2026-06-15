import { Routes } from '@angular/router';
import { LoginForm } from './components/login/login-form/login-form';
import { Dashboard } from './components/dashboard/dashboard/dashboard';
import { BillMenagment } from './components/bill-menagment/bill-menagment';
import { RequestFunds } from './components/request-funds/request-funds';
import { Report } from './components/report/report';

export const routes: Routes = [
    {
        path: '',
        component: LoginForm
    },
    {
        path: 'dashboard',
        component: Dashboard
    },
    {
        path: 'bills',
        component: BillMenagment
    },
    {
        path: 'request-funds',
        component: RequestFunds
    },
    {
        path: 'report',
        component: Report
    }
];
