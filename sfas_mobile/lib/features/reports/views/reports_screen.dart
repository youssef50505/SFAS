import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../viewmodels/report_viewmodel.dart';
import '../../../core/constants/app_colors.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  String _selectedType = 'COLLECTIONS';
  String _selectedFormat = 'PDF';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ReportViewModel>().fetchReports();
    });
  }

  void _generateReport() async {
    final viewModel = context.read<ReportViewModel>();
    final success = await viewModel.generateReport(_selectedType, _selectedFormat);
    
    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Report generated successfully')),
      );
    } else if (mounted && viewModel.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(viewModel.errorMessage!)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
      ),
      body: Column(
        children: [
          _buildGeneratorCard(context),
          Expanded(child: _buildReportsList(context)),
        ],
      ),
    );
  }

  Widget _buildGeneratorCard(BuildContext context) {
    final isLoading = context.watch<ReportViewModel>().isLoading;

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Generate New Report',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Report Type'),
                    initialValue: _selectedType,
                    items: const [
                      DropdownMenuItem(value: 'COLLECTIONS', child: Text('Collections')),
                      DropdownMenuItem(value: 'BILLS', child: Text('Bills')),
                      DropdownMenuItem(value: 'FUNDS', child: Text('Funds')),
                      DropdownMenuItem(value: 'INVENTORY', child: Text('Inventory')),
                    ],
                    onChanged: (value) => setState(() => _selectedType = value!),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Format'),
                    initialValue: _selectedFormat,
                    items: const [
                      DropdownMenuItem(value: 'PDF', child: Text('PDF')),
                      DropdownMenuItem(value: 'EXCEL', child: Text('Excel')),
                    ],
                    onChanged: (value) => setState(() => _selectedFormat = value!),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: isLoading ? null : _generateReport,
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Generate Report'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportsList(BuildContext context) {
    return Consumer<ReportViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading && viewModel.reports.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (viewModel.errorMessage != null && viewModel.reports.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(viewModel.errorMessage!, style: const TextStyle(color: AppColors.danger)),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => viewModel.fetchReports(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (viewModel.reports.isEmpty) {
          return const Center(child: Text('No reports generated yet'));
        }

        return RefreshIndicator(
          onRefresh: () => viewModel.fetchReports(),
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: viewModel.reports.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final report = viewModel.reports[index];
              return Card(
                child: ListTile(
                  leading: Icon(
                    report.format == 'PDF' ? Icons.picture_as_pdf : Icons.table_chart,
                    color: report.format == 'PDF' ? AppColors.danger : AppColors.success,
                  ),
                  title: Text('${report.type} Report', style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(
                    DateFormat.yMMMd().add_jm().format(DateTime.parse(report.generatedAt)),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.download),
                    onPressed: () {
                      // Implementation for downloading or opening URL
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Downloading report...')),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
