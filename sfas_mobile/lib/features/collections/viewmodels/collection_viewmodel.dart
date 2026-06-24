import 'package:flutter/material.dart';
import '../models/collection_metrics.dart';
import '../services/collection_service.dart';

class CollectionViewModel extends ChangeNotifier {
  final CollectionService _service;

  CollectionViewModel(this._service);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  CollectionMetrics? _metrics;
  CollectionMetrics? get metrics => _metrics;

  Future<void> fetchMetrics() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _metrics = await _service.getMetrics();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to load collections metrics';
      notifyListeners();
    }
  }
}
