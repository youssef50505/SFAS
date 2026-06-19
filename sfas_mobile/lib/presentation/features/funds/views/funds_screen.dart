import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/models/fund.dart';
import '../bloc/funds_bloc.dart';
import '../bloc/funds_event.dart';
import '../bloc/funds_state.dart';

class FundsScreen extends StatefulWidget {
  const FundsScreen({super.key});

  @override
  State<FundsScreen> createState() => _FundsScreenState();
}

class _FundsScreenState extends State<FundsScreen> {


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Funds Allocation'),
      ),
      body: BlocBuilder<FundsBloc, FundsState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (message) => Center(child: Text(message, style: const TextStyle(color: Colors.red))),
            loaded: (funds) {
              if (funds.isEmpty) {
                return const Center(child: Text('No funds found'));
              }
              return ListView.builder(
                padding: const EdgeInsets.all(24.0),
                itemCount: funds.length,
                itemBuilder: (context, index) {
                  final fund = funds[index];
                  return _buildFundCard(context, fund).animate().fadeIn(delay: (100 * index).ms).slideY(begin: 0.1);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCreateFundSheet(context),
        backgroundColor: theme.colorScheme.primary,
        icon: const Icon(Remix.add_line, color: Colors.white),
        label: const Text('Request Fund', style: TextStyle(color: Colors.white)),
      ).animate().scale(delay: 500.ms),
    );
  }

  Widget _buildFundCard(BuildContext context, Fund fund) {
    final theme = Theme.of(context);
    
    Color statusColor;
    switch (fund.status) {
      case 'APPROVED': statusColor = Colors.green; break;
      case 'REJECTED': statusColor = Colors.red; break;
      default: statusColor = Colors.orange;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      child: InkWell(
        onTap: () => _showReviewSheet(context, fund),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(fund.urgencyLevel, style: theme.textTheme.bodySmall?.copyWith(color: fund.urgencyLevel == 'HIGH' ? Colors.red : Colors.blue, fontWeight: FontWeight.bold)),
                  Text(fund.status, style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 8),
              Text(fund.title, style: theme.textTheme.headlineMedium),
              const SizedBox(height: 4),
              Text(fund.description, style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey)),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('\$${fund.amountOfFund.toStringAsFixed(2)}', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                  Text(fund.date, style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCreateFundSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 24,
            right: 24,
            top: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Request Fund', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 24),
              TextFormField(decoration: const InputDecoration(labelText: 'Title', border: OutlineInputBorder())),
              const SizedBox(height: 16),
              TextFormField(decoration: const InputDecoration(labelText: 'Amount', border: OutlineInputBorder()), keyboardType: TextInputType.number),
              const SizedBox(height: 16),
              TextFormField(decoration: const InputDecoration(labelText: 'Description', border: OutlineInputBorder()), maxLines: 3),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  context.read<FundsBloc>().add(FundsEvent.createFund({
                    'title': 'New Fund',
                    'description': 'Description',
                    'amountOfFund': 500.0,
                    'urgencyLevel': 'MEDIUM',
                  }));
                  Navigator.pop(context);
                },
                child: const Text('Submit Request'),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  void _showReviewSheet(BuildContext context, Fund fund) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 24,
            right: 24,
            top: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Review Fund Request', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 8),
              Text(fund.title, style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 24),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Review Comments',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        context.read<FundsBloc>().add(FundsEvent.updateFundStatus(fund.id, 'REJECTED'));
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Reject'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<FundsBloc>().add(FundsEvent.updateFundStatus(fund.id, 'APPROVED'));
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Approve'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }
}
