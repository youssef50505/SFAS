import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:remixicon/remixicon.dart';
import '../../../../domain/models/collection.dart';

class CollectionsScreen extends StatefulWidget {
  const CollectionsScreen({super.key});

  @override
  State<CollectionsScreen> createState() => _CollectionsScreenState();
}

class _CollectionsScreenState extends State<CollectionsScreen> {
  final List<Collection> _mockCollections = [
    Collection(id: '1', date: '2026-06-18', type: 'Tuition Fee', amount: 5000.00),
    Collection(id: '2', date: '2026-06-18', type: 'Library Fine', amount: 25.00),
    Collection(id: '3', date: '2026-06-17', type: 'Cafeteria Deposit', amount: 1500.00),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Collections Log'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(24.0),
        itemCount: _mockCollections.length,
        itemBuilder: (context, index) {
          final collection = _mockCollections[index];
          return _buildCollectionCard(context, collection).animate().fadeIn(delay: (100 * index).ms).slideY(begin: 0.1);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showLogCollectionSheet(context),
        backgroundColor: theme.colorScheme.primary,
        icon: const Icon(Remix.add_line, color: Colors.white),
        label: const Text('Log Collection', style: TextStyle(color: Colors.white)),
      ).animate().scale(delay: 500.ms),
    );
  }

  Widget _buildCollectionCard(BuildContext context, Collection collection) {
    final theme = Theme.of(context);
    
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Remix.exchange_dollar_fill, color: theme.colorScheme.primary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(collection.type, style: theme.textTheme.headlineMedium),
                  const SizedBox(height: 4),
                  Text(collection.date, style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey)),
                ],
              ),
            ),
            Text('+\$${collection.amount.toStringAsFixed(2)}', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.green)),
          ],
        ),
      ),
    );
  }

  void _showLogCollectionSheet(BuildContext context) {
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
              Text('Log New Collection', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 24),
              TextFormField(decoration: const InputDecoration(labelText: 'Type (e.g. Tuition)', border: OutlineInputBorder())),
              const SizedBox(height: 16),
              TextFormField(decoration: const InputDecoration(labelText: 'Amount', border: OutlineInputBorder()), keyboardType: TextInputType.number),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Save Collection'),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }
}
