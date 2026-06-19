import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/models/bill.dart';
import '../bloc/bills_bloc.dart';
import '../bloc/bills_event.dart';
import '../bloc/bills_state.dart';

class BillsScreen extends StatefulWidget {
  const BillsScreen({super.key});

  @override
  State<BillsScreen> createState() => _BillsScreenState();
}

class _BillsScreenState extends State<BillsScreen> {

  @override
  void initState() {
    super.initState();
    context.read<BillsBloc>().add(const BillsEvent.loadBills());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bills Management'),
        actions: [
          IconButton(
            icon: const Icon(Remix.filter_3_line),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocBuilder<BillsBloc, BillsState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (message) => Center(child: Text(message, style: const TextStyle(color: Colors.red))),
            loaded: (bills) {
              if (bills.isEmpty) {
                return const Center(child: Text('No bills found'));
              }
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<BillsBloc>().add(const BillsEvent.loadBills());
                },
                child: ListView.builder(
                  padding: const EdgeInsets.all(24.0),
                  itemCount: bills.length,
                  itemBuilder: (context, index) {
                    final bill = bills[index];
                    return _buildBillCard(context, bill).animate().fadeIn(delay: (100 * index).ms).slideY(begin: 0.1);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCreateBillSheet(context),
        backgroundColor: theme.colorScheme.primary,
        icon: const Icon(Remix.add_line, color: Colors.white),
        label: const Text('New Bill', style: TextStyle(color: Colors.white)),
      ).animate().scale(delay: 500.ms),
    );
  }

  Widget _buildBillCard(BuildContext context, Bill bill) {
    final theme = Theme.of(context);
    Color statusColor;
    IconData statusIcon;

    switch (bill.status) {
      case 'APPROVED':
        statusColor = Colors.green;
        statusIcon = Remix.check_double_line;
        break;
      case 'REJECTED':
        statusColor = Colors.red;
        statusIcon = Remix.close_circle_line;
        break;
      default:
        statusColor = Colors.orange;
        statusIcon = Remix.time_line;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      child: InkWell(
        onTap: () => _showReviewSheet(context, bill),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    bill.vendor?.name ?? 'Unknown Vendor',
                    style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(statusIcon, size: 14, color: statusColor),
                        const SizedBox(width: 4),
                        Text(
                          bill.status ?? 'UNKNOWN',
                          style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(bill.title ?? 'No Title', style: theme.textTheme.headlineMedium),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Amount', style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey)),
                      Text('\$${(bill.amount ?? 0).toStringAsFixed(2)}', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Date', style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey)),
                      Text(bill.date ?? 'No Date', style: theme.textTheme.bodyLarge),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCreateBillSheet(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final titleController = TextEditingController();
    final amountController = TextEditingController();
    final vendorIdController = TextEditingController();
    final descriptionController = TextEditingController();

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
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Create New Bill', style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 24),
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Title', border: OutlineInputBorder()),
                  validator: (value) => value == null || value.isEmpty ? 'Required field' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: amountController,
                  decoration: const InputDecoration(labelText: 'Amount', border: OutlineInputBorder()),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  validator: (value) => value == null || double.tryParse(value) == null ? 'Enter valid amount' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: vendorIdController,
                  decoration: const InputDecoration(labelText: 'Vendor ID', border: OutlineInputBorder()),
                  validator: (value) => value == null || value.isEmpty ? 'Required field' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description', border: OutlineInputBorder()),
                  maxLines: 2,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.read<BillsBloc>().add(BillsEvent.createBill({
                        'title': titleController.text,
                        'amount': double.parse(amountController.text),
                        'tax': double.parse(amountController.text) * 0.15, // standard tax 15%
                        'vendorId': vendorIdController.text,
                        'description': descriptionController.text,
                        'date': DateTime.now().toIso8601String(),
                      }));
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Submit Bill'),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showReviewSheet(BuildContext context, Bill bill) {
    final commentController = TextEditingController();

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
              Text('Review Bill', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 8),
              Text(bill.title ?? 'No Title', style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 24),
              TextFormField(
                controller: commentController,
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
                        context.read<BillsBloc>().add(BillsEvent.updateBillStatus(
                          bill.id ?? '', 
                          'REJECTED', 
                          reviewComments: commentController.text,
                        ));
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
                        context.read<BillsBloc>().add(BillsEvent.updateBillStatus(
                          bill.id ?? '', 
                          'APPROVED', 
                          reviewComments: commentController.text,
                        ));
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
