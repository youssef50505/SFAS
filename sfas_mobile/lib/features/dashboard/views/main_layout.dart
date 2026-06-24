import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../auth/viewmodels/auth_viewmodel.dart';
import '../../../core/constants/app_colors.dart';

class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/dashboard')) return 0;
    if (location.startsWith('/bills')) return 1;
    if (location.startsWith('/funds')) return 2;
    if (location.startsWith('/vendors')) return 3;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/dashboard');
        break;
      case 1:
        context.go('/bills');
        break;
      case 2:
        context.go('/funds');
        break;
      case 3:
        context.go('/vendors');
        break;
      case 4:
        _showMoreMenu(context);
        break;
    }
  }

  void _showMoreMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 24),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.inventory_2_rounded, color: AppColors.primary),
                  ),
                  title: const Text('Inventory Items', style: TextStyle(fontWeight: FontWeight.w600)),
                  onTap: () {
                    context.pop();
                    context.go('/items');
                  },
                ),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.analytics_rounded, color: AppColors.primary),
                  ),
                  title: const Text('System Reports', style: TextStyle(fontWeight: FontWeight.w600)),
                  onTap: () {
                    context.pop();
                    context.go('/reports');
                  },
                ),
                const Divider(height: 32),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.danger.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.logout_rounded, color: AppColors.danger),
                  ),
                  title: const Text('Sign Out', style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.danger)),
                  onTap: () {
                    context.pop();
                    context.read<AuthViewModel>().logout();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _calculateSelectedIndex(context);

    return Scaffold(
      body: child.animate().fadeIn(duration: 300.ms),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (idx) => _onItemTapped(idx, context),
        backgroundColor: Colors.white,
        elevation: 16,
        shadowColor: Colors.black.withValues(alpha: 0.1),
        indicatorColor: AppColors.primary.withValues(alpha: 0.1),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard_rounded, color: AppColors.primary),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long_rounded, color: AppColors.primary),
            label: 'Bills',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_balance_wallet_outlined),
            selectedIcon: Icon(Icons.account_balance_wallet_rounded, color: AppColors.primary),
            label: 'Funds',
          ),
          NavigationDestination(
            icon: Icon(Icons.storefront_outlined),
            selectedIcon: Icon(Icons.storefront_rounded, color: AppColors.primary),
            label: 'Vendors',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_rounded),
            label: 'More',
          ),
        ],
      ),
    );
  }
}
