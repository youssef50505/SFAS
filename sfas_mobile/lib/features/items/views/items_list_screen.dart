import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../viewmodels/item_viewmodel.dart';
import '../../../core/constants/app_colors.dart';

class ItemsListScreen extends StatefulWidget {
  const ItemsListScreen({super.key});

  @override
  State<ItemsListScreen> createState() => _ItemsListScreenState();
}

class _ItemsListScreenState extends State<ItemsListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ItemViewModel>().fetchItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.simpleCurrency(name: 'EGP');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Items'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/items/add'),
          ),
        ],
      ),
      body: Consumer<ItemViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading && viewModel.items.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.errorMessage != null && viewModel.items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(viewModel.errorMessage!, style: const TextStyle(color: AppColors.danger)),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => viewModel.fetchItems(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (viewModel.items.isEmpty) {
            return const Center(child: Text('No items found'));
          }

          return RefreshIndicator(
            onRefresh: () => viewModel.fetchItems(),
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: viewModel.items.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final item = viewModel.items[index];
                return Card(
                  child: ListTile(
                    title: Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(
                      'Stock: ${item.currentStock}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    trailing: Text(
                      formatCurrency.format(item.unitPrice),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      context.push('/items/edit', extra: item);
                    },
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
