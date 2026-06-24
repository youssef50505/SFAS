import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../auth/viewmodels/auth_viewmodel.dart';

class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SFAS Mobile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthViewModel>().logout();
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: const Text(
                'SFAS Navigation',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () {
                context.pop();
                context.go('/dashboard');
              },
            ),
            ListTile(
              leading: const Icon(Icons.store),
              title: const Text('Vendors'),
              onTap: () {
                context.pop();
                context.go('/vendors');
              },
            ),
            ListTile(
              leading: const Icon(Icons.receipt_long),
              title: const Text('Bills'),
              onTap: () {
                context.pop();
                context.go('/bills');
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_balance_wallet),
              title: const Text('Funds'),
              onTap: () {
                context.pop();
                context.go('/funds');
              },
            ),
            ListTile(
              leading: const Icon(Icons.inventory),
              title: const Text('Items'),
              onTap: () {
                context.pop();
                context.go('/items');
              },
            ),
            ListTile(
              leading: const Icon(Icons.analytics),
              title: const Text('Reports'),
              onTap: () {
                context.pop();
                context.go('/reports');
              },
            ),
            // We will add more links here later
          ],
        ),
      ),
      body: child,
    );
  }
}
