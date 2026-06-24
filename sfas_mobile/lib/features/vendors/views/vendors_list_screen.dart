import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../viewmodels/vendor_viewmodel.dart';
import '../../../core/constants/app_colors.dart';

class VendorsListScreen extends StatefulWidget {
  const VendorsListScreen({super.key});

  @override
  State<VendorsListScreen> createState() => _VendorsListScreenState();
}

class _VendorsListScreenState extends State<VendorsListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<VendorViewModel>().fetchVendors();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vendors'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/vendors/add'),
          ),
        ],
      ),
      body: Consumer<VendorViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading && viewModel.vendors.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.errorMessage != null && viewModel.vendors.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(viewModel.errorMessage!, style: const TextStyle(color: AppColors.danger)),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => viewModel.fetchVendors(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (viewModel.vendors.isEmpty) {
            return const Center(child: Text('No vendors found'));
          }

          return RefreshIndicator(
            onRefresh: () => viewModel.fetchVendors(),
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: viewModel.vendors.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final vendor = viewModel.vendors[index];
                return Card(
                  child: ListTile(
                    title: Text(vendor.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(vendor.contactEmail),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      context.push('/vendors/edit', extra: vendor);
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
