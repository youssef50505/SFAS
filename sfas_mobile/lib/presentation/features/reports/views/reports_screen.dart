import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/models/report.dart';
import '../bloc/reports_bloc.dart';
import '../bloc/reports_event.dart';
import '../bloc/reports_state.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
      ),
      body: BlocBuilder<ReportsBloc, ReportsState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (message) => Center(child: Text(message, style: const TextStyle(color: Colors.red))),
            loaded: (reports) {
              if (reports.isEmpty) {
                return const Center(child: Text('No reports found'));
              }
              return ListView.builder(
                padding: const EdgeInsets.all(24.0),
                itemCount: reports.length,
                itemBuilder: (context, index) {
                  final report = reports[index];
                  return _buildReportCard(context, report).animate().fadeIn(delay: (100 * index).ms).slideY(begin: 0.1);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showGenerateReportSheet(context),
        backgroundColor: theme.colorScheme.primary,
        icon: const Icon(Remix.magic_line, color: Colors.white),
        label: const Text('Generate AI Report', style: TextStyle(color: Colors.white)),
      ).animate().scale(delay: 500.ms),
    );
  }

  Widget _buildReportCard(BuildContext context, Report report) {
    final theme = Theme.of(context);
    
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      child: InkWell(
        onTap: () {}, // Open report PDF/View
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Remix.file_pdf_2_fill, color: Colors.blue),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(report.title, style: theme.textTheme.headlineMedium),
                    const SizedBox(height: 4),
                    Text(report.description, style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey)),
                    const SizedBox(height: 8),
                    Text('${report.typeOfReport} • ${report.date}', style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const Icon(Remix.download_2_line, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  void _showGenerateReportSheet(BuildContext context) {
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
              Row(
                children: [
                  Icon(Remix.sparkling_fill, color: Theme.of(context).colorScheme.primary),
                  const SizedBox(width: 8),
                  Text('AI Report Generation', style: Theme.of(context).textTheme.headlineMedium),
                ],
              ),
              const SizedBox(height: 24),
              TextFormField(decoration: const InputDecoration(labelText: 'Report Focus (e.g. Q2 Spending)', border: OutlineInputBorder())),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Report Type', border: OutlineInputBorder()),
                items: ['MONTHLY', 'QUARTERLY', 'ANNUAL', 'CUSTOM'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (_) {},
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  context.read<ReportsBloc>().add(ReportsEvent.createReport({
                    'title': 'New AI Report',
                    'description': 'Generated by user',
                    'typeOfReport': 'CUSTOM',
                  }));
                  Navigator.pop(context);
                },
                child: const Text('Generate Document'),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }
}
