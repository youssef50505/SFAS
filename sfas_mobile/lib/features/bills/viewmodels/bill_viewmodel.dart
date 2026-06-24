import 'package:flutter/material.dart';
import '../models/bill.dart';
import '../services/bill_service.dart';

class BillViewModel extends ChangeNotifier {
  final BillService _service;

  BillViewModel(this._service);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<Bill> _bills = [];
  List<Bill> get bills => _bills;

  Future<void> fetchBills() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _bills = await _service.getBills();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to load bills';
      notifyListeners();
    }
  }

  Future<bool> createBill(Bill bill) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final newBill = await _service.createBill(bill);
      _bills.add(newBill);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to create bill';
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateBill(String id, Bill bill) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final updatedBill = await _service.updateBill(id, bill);
      final index = _bills.indexWhere((b) => b.id == id);
      if (index != -1) {
        _bills[index] = updatedBill;
      }
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to update bill';
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateBillStatus(String id, String status) async {
    try {
      final updatedBill = await _service.updateBillStatus(id, status);
      final index = _bills.indexWhere((b) => b.id == id);
      if (index != -1) {
        _bills[index] = updatedBill;
        notifyListeners();
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteBill(String id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _service.deleteBill(id);
      _bills.removeWhere((b) => b.id == id);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to delete bill';
      notifyListeners();
      return false;
    }
  }
}
