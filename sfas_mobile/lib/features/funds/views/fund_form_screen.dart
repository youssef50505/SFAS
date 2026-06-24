import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../models/fund.dart';
import '../viewmodels/fund_viewmodel.dart';

class FundFormScreen extends StatefulWidget {
  const FundFormScreen({super.key});

  @override
  State<FundFormScreen> createState() => _FundFormScreenState();
}

class _FundFormScreenState extends State<FundFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _amountController;
  String _urgencyLevel = 'LOW';

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _amountController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final viewModel = context.read<FundViewModel>();
      
      final fundData = Fund(
        id: '', // backend generated
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        amountOfFund: double.tryParse(_amountController.text.trim()) ?? 0.0,
        urgencyLevel: _urgencyLevel,
        status: 'PENDING',
        date: DateTime.now().toIso8601String(),
      );

      final success = await viewModel.createFund(fundData);

      if (success && mounted) {
        context.pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Fund request created successfully')),
        );
      } else if (mounted && viewModel.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(viewModel.errorMessage!)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<FundViewModel>().isLoading;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Fund'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Fund Title'),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _amountController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: 'Amount Requested (EGP)'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Required';
                  if (double.tryParse(value) == null) return 'Must be a valid number';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _urgencyLevel,
                decoration: const InputDecoration(labelText: 'Urgency Level'),
                items: ['LOW', 'MEDIUM', 'HIGH', 'CRITICAL'].map((level) {
                  return DropdownMenuItem(value: level, child: Text(level));
                }).toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _urgencyLevel = val);
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: isLoading ? null : _submit,
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Submit Request'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
