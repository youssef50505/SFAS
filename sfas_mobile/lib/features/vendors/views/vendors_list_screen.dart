import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Vendors', style: TextStyle(fontWeight: FontWeight.w700)),
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
              onPressed: () => context.push('/vendors/add'),
            ),
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
                    onPressed: () => viewModel.fetchVendors(),
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

          if (viewModel.vendors.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.storefront_outlined, size: 80, color: Colors.grey.shade300),
                  const SizedBox(height: 16),
                  Text('No vendors found', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.grey.shade500)),
                  const SizedBox(height: 8),
                  Text('Tap the + button to add your first vendor.', style: TextStyle(color: Colors.grey.shade400)),
                ],
              ),
            ).animate().fadeIn().slideY(begin: 0.1);
          }

          return RefreshIndicator(
            onRefresh: () => viewModel.fetchVendors(),
            color: AppColors.primary,
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: viewModel.vendors.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final vendor = viewModel.vendors[index];
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
                        context.push('/vendors/edit', extra: vendor);
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
                              child: Center(
                                child: Text(
                                  vendor.name.substring(0, 1).toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    vendor.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(Icons.email_outlined, size: 14, color: AppColors.textSecondary),
                                      const SizedBox(width: 4),
                                      Text(
                                        vendor.contactEmail,
                                        style: const TextStyle(
                                          color: AppColors.textSecondary,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.chevron_right_rounded, color: Colors.grey),
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
