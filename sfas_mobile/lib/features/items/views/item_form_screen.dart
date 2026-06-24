import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../models/item.dart';
import '../viewmodels/item_viewmodel.dart';

class ItemFormScreen extends StatefulWidget {
  final Item? item;

  const ItemFormScreen({super.key, this.item});

  @override
  State<ItemFormScreen> createState() => _ItemFormScreenState();
}

class _ItemFormScreenState extends State<ItemFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  String _category = 'ELECTRONICS';

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.item?.name ?? '');
    _descriptionController = TextEditingController(text: widget.item?.description ?? '');
    _priceController = TextEditingController(text: widget.item?.price.toString() ?? '');
    if (widget.item != null) {
      _category = widget.item!.category;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final viewModel = context.read<ItemViewModel>();
      
      final itemData = Item(
        id: widget.item?.id ?? '', // backend generated
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim(),
        price: double.tryParse(_priceController.text.trim()) ?? 0.0,
        category: _category,
      );

      bool success;
      if (widget.item == null) {
        success = await viewModel.createItem(itemData);
      } else {
        success = await viewModel.updateItem(widget.item!.id, itemData);
      }

      if (success && mounted) {
        context.pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(widget.item == null ? 'Item created successfully' : 'Item updated successfully')),
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
    final isLoading = context.watch<ItemViewModel>().isLoading;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item == null ? 'Add Item' : 'Edit Item'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Item Name'),
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
                controller: _priceController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: 'Price (EGP)'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Required';
                  if (double.tryParse(value) == null) return 'Must be a valid number';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _category,
                decoration: const InputDecoration(labelText: 'Category'),
                items: ['ELECTRONICS', 'FURNITURE', 'BOOKS', 'SUPPLIES', 'OTHER'].map((cat) {
                  return DropdownMenuItem(value: cat, child: Text(cat));
                }).toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _category = val);
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: isLoading ? null : _submit,
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(widget.item == null ? 'Create Item' : 'Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
