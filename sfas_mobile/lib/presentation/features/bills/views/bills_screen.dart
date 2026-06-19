import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:remixicon/remixicon.dart';
import '../../../../domain/models/bill.dart';
import '../../../../domain/models/vendor.dart';

class BillsScreen extends StatefulWidget {
  const BillsScreen({super.key});

  @override
  State<BillsScreen> createState() => _BillsScreenState();
}

class _BillsScreenState extends State<BillsScreen> {
  // Mock data to demonstrate the UI
  final List<Bill> _mockBills = [
    Bill(id: '1', title: 'Office Supplies', amount: 450.00, tax: 45.0, date: '2026-06-15', description: 'Pens, paper, printer ink', status: 'PENDING', vendor: const Vendor(id: 'v1', name: 'Staples Inc', contactEmail: 'contact@staples.com', phoneNumber: '555-1234', taxId: 'TAX123', address: '123 Main St')),
    Bill(id: '2', title: 'Software Licenses', amount: 1200.00, tax: 0.0, date: '2026-06-10', description: 'Annual IDE licenses', status: 'APPROVED', vendor: const Vendor(id: 'v2', name: 'JetBrains', contactEmail: 'sales@jetbrains.com', phoneNumber: '555-9876', taxId: 'TAX987', address: '456 Tech Park')),
    Bill(id: '3', title: 'Catering Service', amount: 850.00, tax: 85.0, date: '2026-06-05', description: 'Board meeting lunch', status: 'REJECTED', reviewComments: 'Amount exceeds standard budget', vendor: const Vendor(id: 'v3', name: 'Fresh Catering', contactEmail: 'hello@fresh.com', phoneNumber: '555-4567', taxId: 'TAX456', address: '789 Food Ave')),
  ];

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
      body: ListView.builder(
        padding: const EdgeInsets.all(24.0),
        itemCount: _mockBills.length,
        itemBuilder: (context, index) {
          final bill = _mockBills[index];
          return _buildBillCard(context, bill).animate().fadeIn(delay: (100 * index).ms).slideY(begin: 0.1);
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
                          bill.status,
                          style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(bill.title, style: theme.textTheme.headlineMedium),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Amount', style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey)),
                      Text('\$${bill.amount.toStringAsFixed(2)}', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Date', style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey)),
                      Text(bill.date, style: theme.textTheme.bodyLarge),
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
              Text('Create New Bill', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 24),
              TextFormField(decoration: const InputDecoration(labelText: 'Title', border: OutlineInputBorder())),
              const SizedBox(height: 16),
              TextFormField(decoration: const InputDecoration(labelText: 'Amount', border: OutlineInputBorder()), keyboardType: TextInputType.number),
              const SizedBox(height: 16),
              TextFormField(decoration: const InputDecoration(labelText: 'Vendor ID', border: OutlineInputBorder())),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Submit Bill'),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  void _showReviewSheet(BuildContext context, Bill bill) {
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
              Text(bill.title, style: Theme.of(context).textTheme.bodyLarge),
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
                      onPressed: () => Navigator.pop(context),
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
                      onPressed: () => Navigator.pop(context),
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
