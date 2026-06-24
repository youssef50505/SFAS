import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
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
    switch (status) {
      case 'ACTIVE':
        return AppColors.success;
      case 'DEPLETED':
        return AppColors.warning;
      case 'CLOSED':
        return AppColors.danger;
      default:
        return AppColors.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.simpleCurrency(name: 'EGP');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Funds'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/funds/add'),
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
                  Text(viewModel.errorMessage!, style: const TextStyle(color: AppColors.danger)),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => viewModel.fetchFunds(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (viewModel.funds.isEmpty) {
            return const Center(child: Text('No funds found'));
          }

          return RefreshIndicator(
            onRefresh: () => viewModel.fetchFunds(),
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: viewModel.funds.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final fund = viewModel.funds[index];
                return Card(
                  child: ListTile(
                    title: Text(fund.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(
                      DateFormat.yMMMd().format(DateTime.parse(fund.dateCreated)),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          formatCurrency.format(fund.initialAmount),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getStatusColor(fund.status).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            fund.status,
                            style: TextStyle(
                              color: _getStatusColor(fund.status),
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
