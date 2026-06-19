import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../notifications/views/notifications_sheet.dart';

class FinanceDashboardScreen extends StatelessWidget {
  const FinanceDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = context.select((AuthBloc bloc) {
      return bloc.state.maybeWhen(
        authenticated: (u) => u,
        orElse: () => null,
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Finance Workspace'),
        actions: [
          IconButton(
            icon: const Icon(Remix.notification_3_line),
            onPressed: () => NotificationsSheet.show(context),
          ),
          IconButton(
            icon: const Icon(Remix.logout_box_r_line),
            onPressed: () => context.read<AuthBloc>().add(const AuthEvent.logoutRequested()),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello, ${user?.name ?? 'Officer'}',
              style: theme.textTheme.displayMedium,
            ).animate().fadeIn().slideX(begin: -0.1),
            const SizedBox(height: 8),
            Text(
              'You have 5 pending tasks requiring attention.',
              style: theme.textTheme.bodyLarge?.copyWith(color: Colors.orange),
            ).animate().fadeIn(delay: 100.ms),
            const SizedBox(height: 32),
            Text('Quick Actions', style: theme.textTheme.headlineMedium).animate().fadeIn(delay: 200.ms),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _buildActionCard(context, 'Review Bills', '3 pending', Remix.receipt_line, Colors.blue),
                _buildActionCard(context, 'Approve Funds', '2 requests', Remix.money_dollar_circle_line, Colors.green),
                _buildActionCard(context, 'New Vendor', 'Onboard', Remix.user_add_line, Colors.purple),
              ],
            ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1),
            const SizedBox(height: 32),
            Text('Recent Activity', style: theme.textTheme.headlineMedium).animate().fadeIn(delay: 400.ms),
            const SizedBox(height: 16),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: Colors.grey.withOpacity(0.2)),
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    leading: CircleAvatar(
                      backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                      child: Icon(Remix.check_line, color: theme.colorScheme.primary),
                    ),
                    title: Text('Bill Payment Approved', style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
                    subtitle: const Text('Vendor: ABC Corp - \$1,200.00'),
                    trailing: Text('2h ago', style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey)),
                  );
                },
              ),
            ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.1),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard(BuildContext context, String title, String subtitle, IconData icon, Color color) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 16),
            Text(title, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(subtitle, style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }
}
