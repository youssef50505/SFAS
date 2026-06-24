import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../viewmodels/report_viewmodel.dart';
import '../../../core/constants/app_colors.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ReportViewModel>().fetchReports();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('System Reports', style: TextStyle(fontWeight: FontWeight.w700)),
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
                child: const Icon(Icons.picture_as_pdf_rounded, color: AppColors.primary),
              ),
              onPressed: () {
                // TODO: Generate new report
              },
            ),
          ),
        ],
      ),
      body: Consumer<ReportViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading && viewModel.reports.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.errorMessage != null && viewModel.reports.isEmpty) {
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
                    onPressed: () => viewModel.fetchReports(),
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

          if (viewModel.reports.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.analytics_outlined, size: 80, color: Colors.grey.shade300),
                  const SizedBox(height: 16),
                  Text('No reports generated', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.grey.shade500)),
                  const SizedBox(height: 8),
                  Text('Tap the PDF button to generate a report.', style: TextStyle(color: Colors.grey.shade400)),
                ],
              ),
            ).animate().fadeIn().slideY(begin: 0.1);
          }

          return RefreshIndicator(
            onRefresh: () => viewModel.fetchReports(),
            color: AppColors.primary,
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: viewModel.reports.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final report = viewModel.reports[index];

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
                        // TODO: Open report URL
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: AppColors.info.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Center(
                                child: Icon(Icons.picture_as_pdf_rounded, color: AppColors.info),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    report.type.replaceAll('_', ' '),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(Icons.calendar_today_outlined, size: 14, color: Colors.grey),
                                      const SizedBox(width: 4),
                                      Text(
                                        DateFormat.yMMMd().add_jm().format(DateTime.parse(report.generatedAt)),
                                        style: const TextStyle(color: Colors.grey, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.download_rounded, color: AppColors.primary),
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
