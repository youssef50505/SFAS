import 'package:flutter/material.dart';
import '../models/fund.dart';
import '../services/fund_service.dart';

class FundViewModel extends ChangeNotifier {
  final FundService _service;

  FundViewModel(this._service);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<Fund> _funds = [];
  List<Fund> get funds => _funds;

  Future<void> fetchFunds() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _funds = await _service.getFunds();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to load funds';
      notifyListeners();
    }
  }

  Future<bool> createFund(Fund fund) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final newFund = await _service.createFund(fund);
      _funds.add(newFund);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to create fund';
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateFundStatus(String id, String status) async {
    try {
      final updatedFund = await _service.updateFundStatus(id, status);
      final index = _funds.indexWhere((f) => f.id == id);
      if (index != -1) {
        _funds[index] = updatedFund;
        notifyListeners();
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
