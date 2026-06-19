import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presentation/features/auth/views/login_screen.dart';
import '../../presentation/features/auth/bloc/auth_bloc.dart';
import '../../presentation/shared/widgets/app_shell.dart';
import '../../presentation/features/dashboard/views/admin_dashboard_screen.dart';
import '../../presentation/features/dashboard/views/finance_dashboard_screen.dart';
import '../../presentation/features/funds/views/funds_screen.dart';
import '../../presentation/features/bills/views/bills_screen.dart';
import '../../presentation/features/collections/views/collections_screen.dart';
import '../../presentation/features/reports/views/reports_screen.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return AppShell(child: child);
        },
        routes: [
          GoRoute(
            path: '/dashboard/admin',
            builder: (context, state) => const AdminDashboardScreen(),
          ),
          GoRoute(
            path: '/dashboard/finance',
            builder: (context, state) => const FinanceDashboardScreen(),
          ),
          GoRoute(
            path: '/funds',
            builder: (context, state) => const FundsScreen(),
          ),
          GoRoute(
            path: '/bills',
            builder: (context, state) => const BillsScreen(),
          ),
          GoRoute(
            path: '/collections',
            builder: (context, state) => const CollectionsScreen(),
          ),
          GoRoute(
            path: '/reports',
            builder: (context, state) => const ReportsScreen(),
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      final authState = context.read<AuthBloc>().state;
      final isLoggingIn = state.uri.path == '/login';

      final isRoot = state.uri.path == '/';

      return authState.maybeWhen(
        authenticated: (user) {
          final isAdmin = user.role.toUpperCase().contains('ADMIN');

          if (isLoggingIn || isRoot) {
            return isAdmin ? '/dashboard/admin' : '/dashboard/finance';
          }
          // Simple role check
          if (state.uri.path == '/dashboard/admin' && !isAdmin) {
             return '/dashboard/finance';
          }
          if (state.uri.path == '/dashboard/finance' && isAdmin) {
             return '/dashboard/admin';
          }
          return null; 
        },
        orElse: () {
          if (!isLoggingIn) {
            return '/login'; 
          }
          return null; 
        },
      );
    },
  );
}
