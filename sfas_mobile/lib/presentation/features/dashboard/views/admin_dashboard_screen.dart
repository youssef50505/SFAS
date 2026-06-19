import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../notifications/views/notifications_sheet.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

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
        title: const Text('Admin Overview'),
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
              'Welcome, ${user?.name ?? 'Admin'}',
              style: theme.textTheme.displayMedium,
            ).animate().fadeIn().slideX(begin: -0.1),
            const SizedBox(height: 8),
            Text(
              'Here is your executive financial overview.',
              style: theme.textTheme.bodyLarge?.copyWith(color: Colors.grey),
            ).animate().fadeIn(delay: 100.ms),
            const SizedBox(height: 32),
            // KPI Cards
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _buildKpiCard(context, 'Total Funds', '\$1.2M', Remix.money_dollar_circle_line, Colors.blue),
                _buildKpiCard(context, 'Pending Bills', '14', Remix.receipt_line, Colors.orange),
                _buildKpiCard(context, 'Monthly Revenue', '\$450K', Remix.line_chart_line, Colors.green),
                _buildKpiCard(context, 'Active Vendors', '32', Remix.store_line, Colors.purple),
              ],
            ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),
            const SizedBox(height: 32),
            // Charts Section
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(color: Colors.grey.withOpacity(0.2)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Revenue vs Expenses', style: theme.textTheme.headlineMedium),
                          const SizedBox(height: 24),
                          SizedBox(
                            height: 300,
                            child: BarChart(
                              BarChartData(
                                alignment: BarChartAlignment.spaceAround,
                                maxY: 20,
                                titlesData: FlTitlesData(show: false),
                                borderData: FlBorderData(show: false),
                                barGroups: [
                                  BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 8, color: theme.colorScheme.primary)]),
                                  BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 10, color: theme.colorScheme.primary)]),
                                  BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 14, color: theme.colorScheme.primary)]),
                                  BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 15, color: theme.colorScheme.primary)]),
                                  BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 13, color: theme.colorScheme.primary)]),
                                  BarChartGroupData(x: 5, barRods: [BarChartRodData(toY: 10, color: theme.colorScheme.primary)]),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ).animate().fadeIn(delay: 300.ms).scale(begin: const Offset(0.95, 0.95)),
                ),
                if (MediaQuery.of(context).size.width > 900) const SizedBox(width: 24),
                if (MediaQuery.of(context).size.width > 900)
                  Expanded(
                    flex: 1,
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(color: Colors.grey.withOpacity(0.2)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Fund Allocation', style: theme.textTheme.headlineMedium),
                            const SizedBox(height: 24),
                            SizedBox(
                              height: 300,
                              child: PieChart(
                                PieChartData(
                                  sectionsSpace: 0,
                                  centerSpaceRadius: 40,
                                  sections: [
                                    PieChartSectionData(value: 40, color: Colors.blue, title: '40%'),
                                    PieChartSectionData(value: 30, color: Colors.green, title: '30%'),
                                    PieChartSectionData(value: 15, color: Colors.orange, title: '15%'),
                                    PieChartSectionData(value: 15, color: Colors.purple, title: '15%'),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ).animate().fadeIn(delay: 400.ms).scale(begin: const Offset(0.95, 0.95)),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildKpiCard(BuildContext context, String title, String value, IconData icon, Color color) {
    final theme = Theme.of(context);
    return Container(
      width: 240,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const Icon(Remix.more_2_fill, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 24),
          Text(title, style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey[600])),
          const SizedBox(height: 8),
          Text(value, style: theme.textTheme.displaySmall),
        ],
      ),
    );
  }
}
