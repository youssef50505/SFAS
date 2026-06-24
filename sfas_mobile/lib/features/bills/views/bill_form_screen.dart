import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../models/bill.dart';
import '../viewmodels/bill_viewmodel.dart';
import '../../vendors/models/vendor.dart';
import '../../vendors/viewmodels/vendor_viewmodel.dart';

class BillFormScreen extends StatefulWidget {
  final Bill? bill;

  const BillFormScreen({super.key, this.bill});

  @override
  State<BillFormScreen> createState() => _BillFormScreenState();
}

class _BillFormScreenState extends State<BillFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _invoiceNumberController;
  late TextEditingController _amountController;
  late TextEditingController _descriptionController;
  
  Vendor? _selectedVendor;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _invoiceNumberController = TextEditingController(text: widget.bill?.invoiceNumber ?? '');
    _amountController = TextEditingController(text: widget.bill?.amount.toString() ?? '');
    _descriptionController = TextEditingController(text: widget.bill?.description ?? '');
    
    if (widget.bill != null) {
      _selectedDate = DateTime.parse(widget.bill!.date);
    }
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vendorVM = context.read<VendorViewModel>();
      if (vendorVM.vendors.isEmpty) {
        vendorVM.fetchVendors();
      } else if (widget.bill != null) {
        try {
          setState(() {
            _selectedVendor = vendorVM.vendors.firstWhere((v) => v.id == widget.bill!.vendor.id);
          });
        } catch (e) {
          // Vendor not found in current list
        }
      }
    });
  }

  @override
  void dispose() {
    _invoiceNumberController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _submit() async {
    if (_formKey.currentState!.validate() && _selectedVendor != null) {
      final viewModel = context.read<BillViewModel>();
      
      final billData = Bill(
        id: widget.bill?.id ?? '', // backend generated
        invoiceNumber: _invoiceNumberController.text.trim(),
        date: _selectedDate.toIso8601String().split('T')[0],
        amount: double.tryParse(_amountController.text.trim()) ?? 0.0,
        description: _descriptionController.text.trim(),
        status: widget.bill?.status ?? 'PENDING',
        vendor: _selectedVendor!,
      );

      bool success;
      if (widget.bill == null) {
        success = await viewModel.createBill(billData);
      } else {
        success = await viewModel.updateBill(widget.bill!.id, billData);
      }

      if (success && mounted) {
        context.pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(widget.bill == null ? 'Bill created successfully' : 'Bill updated successfully')),
        );
      } else if (mounted && viewModel.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(viewModel.errorMessage!)),
        );
      }
    } else if (_selectedVendor == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a vendor')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<BillViewModel>().isLoading;
    final vendorVM = context.watch<VendorViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.bill == null ? 'Add Bill' : 'Edit Bill'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField<Vendor>(
                decoration: const InputDecoration(labelText: 'Vendor'),
                initialValue: _selectedVendor,
                items: vendorVM.vendors.map((Vendor vendor) {
                  return DropdownMenuItem<Vendor>(
                    value: vendor,
                    child: Text(vendor.name),
                  );
                }).toList(),
                onChanged: (Vendor? newValue) {
                  setState(() {
                    _selectedVendor = newValue;
                  });
                },
                validator: (value) => value == null ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _invoiceNumberController,
                decoration: const InputDecoration(labelText: 'Invoice Number'),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () => _selectDate(context),
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Date'),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(DateFormat.yMMMd().format(_selectedDate)),
                      const Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _amountController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: 'Amount (EGP)'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Required';
                  if (double.tryParse(value) == null) return 'Must be a valid number';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: isLoading ? null : _submit,
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(widget.bill == null ? 'Create Bill' : 'Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
