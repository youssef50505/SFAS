import 'package:flutter/material.dart';
import '../models/vendor.dart';
import '../services/vendor_service.dart';

class VendorViewModel extends ChangeNotifier {
  final VendorService _service;

  VendorViewModel(this._service);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<Vendor> _vendors = [];
  List<Vendor> get vendors => _vendors;

  Future<void> fetchVendors() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _vendors = await _service.getVendors();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to load vendors';
      notifyListeners();
    }
  }

  Future<bool> createVendor(Vendor vendor) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final newVendor = await _service.createVendor(vendor);
      _vendors.add(newVendor);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to create vendor';
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateVendor(String id, Vendor vendor) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final updatedVendor = await _service.updateVendor(id, vendor);
      final index = _vendors.indexWhere((v) => v.id == id);
      if (index != -1) {
        _vendors[index] = updatedVendor;
      }
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to update vendor';
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteVendor(String id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _service.deleteVendor(id);
      _vendors.removeWhere((v) => v.id == id);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to delete vendor';
      notifyListeners();
      return false;
    }
  }
}
