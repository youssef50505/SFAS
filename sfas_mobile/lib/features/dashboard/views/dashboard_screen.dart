import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../auth/viewmodels/auth_viewmodel.dart';
import '../../collections/viewmodels/collection_viewmodel.dart';
import '../../../core/constants/app_colors.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CollectionViewModel>().fetchMetrics();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();
    final user = authViewModel.currentUser;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Consumer<CollectionViewModel>(
        builder: (context, viewModel, child) {
          return CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              // Hero Header
              SliverAppBar(
                expandedHeight: 180.0,
                floating: false,
                pinned: true,
                backgroundColor: AppColors.primary,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: const EdgeInsets.only(left: 24, bottom: 16, right: 24),
                  title: Text(
                    'Hello, ${user?.name.split(' ').first ?? 'User'}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppColors.primary,
                              AppColors.primary.withValues(alpha: 0.8),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        right: -50,
                        top: -50,
                        child: Icon(
                          Icons.account_balance_wallet,
                          size: 200,
                          color: Colors.white.withValues(alpha: 0.1),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Content Body
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Financial Overview',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ).animate().fadeIn().slideX(),
                      
                      const SizedBox(height: 24),

                      if (viewModel.isLoading)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(32.0),
                            child: CircularProgressIndicator(),
                          ),
                        )
                      else if (viewModel.errorMessage != null)
                        Center(
                          child: Column(
                            children: [
                              const Icon(Icons.error_outline, size: 48, color: AppColors.danger),
                              const SizedBox(height: 16),
                              Text(viewModel.errorMessage!, style: const TextStyle(color: AppColors.danger)),
                              TextButton.icon(
                                onPressed: () => viewModel.fetchMetrics(),
                                icon: const Icon(Icons.refresh),
                                label: const Text('Retry'),
                              ),
                            ],
                          ),
                        )
                      else if (viewModel.metrics != null)
                        GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          childAspectRatio: 1.1,
                          children: [
                            _buildMetricCard(
                              context: context,
                              title: 'Daily Collections',
                              value: viewModel.metrics!.today,
                              icon: Icons.today_rounded,
                              iconColor: AppColors.info,
                              delay: 100,
                            ),
                            _buildMetricCard(
                              context: context,
                              title: 'Weekly Collections',
                              value: viewModel.metrics!.weekly,
                              icon: Icons.view_week_rounded,
                              iconColor: AppColors.warning,
                              delay: 200,
                            ),
                            _buildMetricCard(
                              context: context,
                              title: 'Monthly Collections',
                              value: viewModel.metrics!.monthly,
                              icon: Icons.calendar_month_rounded,
                              iconColor: AppColors.success,
                              delay: 300,
                            ),
                            _buildMetricCard(
                              context: context,
                              title: 'Annual Collections',
                              value: viewModel.metrics!.annually,
                              icon: Icons.auto_graph_rounded,
                              iconColor: AppColors.primary,
                              delay: 400,
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMetricCard({
    required BuildContext context,
    required String title,
    required double value,
    required IconData icon,
    required Color iconColor,
    required int delay,
  }) {
    final formatCurrency = NumberFormat.simpleCurrency(name: 'EGP');
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: iconColor.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 24),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                formatCurrency.format(value),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 22,
                  color: AppColors.textPrimary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(delay: delay.ms).slideY(begin: 0.2);
  }
}
