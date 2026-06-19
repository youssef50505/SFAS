import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/auth/bloc/auth_bloc.dart';
import 'app_bottom_navigation.dart';

class AppShell extends StatefulWidget {
  final Widget child;
  
  const AppShell({super.key, required this.child});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/dashboard')) return 0;
    if (location.startsWith('/funds')) return 1;
    if (location.startsWith('/bills')) return 2;
    if (location.startsWith('/collections')) return 3;
    if (location.startsWith('/reports')) return 4;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    final authState = context.read<AuthBloc>().state;
    final role = authState.maybeWhen(
      authenticated: (user) => user.role,
      orElse: () => '',
    );
    final baseDash = role == 'ROLE_ADMIN' ? '/dashboard/admin' : '/dashboard/finance';

    switch (index) {
      case 0:
        context.go(baseDash);
        break;
      case 1:
        context.go('/funds');
        break;
      case 2:
        context.go('/bills');
        break;
      case 3:
        context.go('/collections');
        break;
      case 4:
        context.go('/reports');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Only show bottom nav on mobile
    final isDesktop = MediaQuery.of(context).size.width > 900;
    final currentIndex = _calculateSelectedIndex(context);

    return Scaffold(
      body: Row(
        children: [
          if (isDesktop)
            NavigationRail(
              selectedIndex: currentIndex,
              onDestinationSelected: (index) => _onItemTapped(index, context),
              labelType: NavigationRailLabelType.all,
              destinations: const [
                NavigationRailDestination(icon: Icon(Icons.dashboard_outlined), selectedIcon: Icon(Icons.dashboard), label: Text('Dashboard')),
                NavigationRailDestination(icon: Icon(Icons.account_balance_wallet_outlined), selectedIcon: Icon(Icons.account_balance_wallet), label: Text('Funds')),
                NavigationRailDestination(icon: Icon(Icons.receipt_outlined), selectedIcon: Icon(Icons.receipt), label: Text('Bills')),
                NavigationRailDestination(icon: Icon(Icons.payments_outlined), selectedIcon: Icon(Icons.payments), label: Text('Collections')),
                NavigationRailDestination(icon: Icon(Icons.bar_chart_outlined), selectedIcon: Icon(Icons.bar_chart), label: Text('Reports')),
              ],
            ),
          Expanded(child: widget.child),
        ],
      ),
      bottomNavigationBar: isDesktop ? null : AppBottomNavigation(
        currentIndex: currentIndex,
        onTabSelected: (index) => _onItemTapped(index, context),
      ),
    );
  }
}
