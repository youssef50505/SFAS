import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../viewmodels/fund_viewmodel.dart';
import '../../../core/constants/app_colors.dart';

class FundsListScreen extends StatefulWidget {
  const FundsListScreen({super.key});

  @override
  State<FundsListScreen> createState() => _FundsListScreenState();
}

class _FundsListScreenState extends State<FundsListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FundViewModel>().fetchFunds();
    });
  }

  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'APPROVED':
        return AppColors.success;
      case 'PENDING':
        return AppColors.warning;
      case 'REJECTED':
        return AppColors.danger;
      default:
        return AppColors.info;
    }
  }

  Color _getUrgencyColor(String urgency) {
    switch (urgency.toUpperCase()) {
      case 'CRITICAL':
        return Colors.red.shade900;
      case 'HIGH':
        return AppColors.danger;
      case 'MEDIUM':
        return AppColors.warning;
      case 'LOW':
        return AppColors.success;
      default:
        return AppColors.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.simpleCurrency(name: 'EGP');

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Funds', style: TextStyle(fontWeight: FontWeight.w700)),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.add, color: AppColors.primary),
              ),
              onPressed: () => context.push('/funds/add'),
            ),
          ),
        ],
      ),
      body: Consumer<FundViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading && viewModel.funds.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.errorMessage != null && viewModel.funds.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppColors.danger.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.error_outline, size: 48, color: AppColors.danger),
                  ),
                  const SizedBox(height: 16),
                  Text(viewModel.errorMessage!, style: const TextStyle(color: AppColors.danger, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () => viewModel.fetchFunds(),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn();
          }

          if (viewModel.funds.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.account_balance_wallet_outlined, size: 80, color: Colors.grey.shade300),
                  const SizedBox(height: 16),
                  Text('No funds found', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.grey.shade500)),
                  const SizedBox(height: 8),
                  Text('Tap the + button to request your first fund.', style: TextStyle(color: Colors.grey.shade400)),
                ],
              ),
            ).animate().fadeIn().slideY(begin: 0.1);
          }

          return RefreshIndicator(
            onRefresh: () => viewModel.fetchFunds(),
            color: AppColors.primary,
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: viewModel.funds.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final fund = viewModel.funds[index];
                final statusColor = _getStatusColor(fund.status);
                final urgencyColor = _getUrgencyColor(fund.urgencyLevel);

                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        // TODO: View fund details
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: urgencyColor.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Icon(Icons.account_balance_wallet_rounded, color: urgencyColor),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    fund.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    fund.description,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: AppColors.textSecondary,
                                      fontSize: 13,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(Icons.calendar_today_outlined, size: 14, color: Colors.grey),
                                      const SizedBox(width: 4),
                                      Text(
                                        DateFormat.yMMMd().format(DateTime.parse(fund.date)),
                                        style: const TextStyle(color: Colors.grey, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  formatCurrency.format(fund.amountOfFund),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: statusColor.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    fund.status,
                                    style: TextStyle(
                                      color: statusColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ).animate().fadeIn(delay: (index * 50).ms).slideX(begin: 0.1);
              },
            ),
          );
        },
      ),
    );
  }
}
