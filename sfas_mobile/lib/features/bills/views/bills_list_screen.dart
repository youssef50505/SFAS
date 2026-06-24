import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../viewmodels/bill_viewmodel.dart';
import '../../../core/constants/app_colors.dart';

class BillsListScreen extends StatefulWidget {
  const BillsListScreen({super.key});

  @override
  State<BillsListScreen> createState() => _BillsListScreenState();
}

class _BillsListScreenState extends State<BillsListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BillViewModel>().fetchBills();
    });
  }

  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'PAID':
      case 'APPROVED':
        return AppColors.success;
      case 'PARTIALLY_PAID':
      case 'PENDING':
        return AppColors.warning;
      case 'CANCELLED':
      case 'REJECTED':
        return AppColors.danger;
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
        title: const Text('Bills', style: TextStyle(fontWeight: FontWeight.w700)),
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
              onPressed: () => context.push('/bills/add'),
            ),
          ),
        ],
      ),
      body: Consumer<BillViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading && viewModel.bills.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.errorMessage != null && viewModel.bills.isEmpty) {
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
                    onPressed: () => viewModel.fetchBills(),
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

          if (viewModel.bills.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.receipt_long_outlined, size: 80, color: Colors.grey.shade300),
                  const SizedBox(height: 16),
                  Text('No bills found', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.grey.shade500)),
                  const SizedBox(height: 8),
                  Text('Tap the + button to add your first bill.', style: TextStyle(color: Colors.grey.shade400)),
                ],
              ),
            ).animate().fadeIn().slideY(begin: 0.1);
          }

          return RefreshIndicator(
            onRefresh: () => viewModel.fetchBills(),
            color: AppColors.primary,
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: viewModel.bills.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final bill = viewModel.bills[index];
                final statusColor = _getStatusColor(bill.status);

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
                        context.push('/bills/edit', extra: bill);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Center(
                                child: Icon(Icons.receipt_long_rounded, color: AppColors.primary),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    bill.invoiceNumber,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(Icons.storefront_outlined, size: 14, color: AppColors.textSecondary),
                                      const SizedBox(width: 4),
                                      Text(
                                        bill.vendor.name,
                                        style: const TextStyle(
                                          color: AppColors.textSecondary,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  Row(
                                    children: [
                                      const Icon(Icons.calendar_today_outlined, size: 14, color: Colors.grey),
                                      const SizedBox(width: 4),
                                      Text(
                                        DateFormat.yMMMd().format(DateTime.parse(bill.date)),
                                        style: const TextStyle(color: Colors.grey, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  formatCurrency.format(bill.amount),
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
                                    bill.status,
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
