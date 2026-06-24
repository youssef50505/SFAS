import 'package:flutter/material.dart';
import '../models/report.dart';
import '../services/report_service.dart';

class ReportViewModel extends ChangeNotifier {
  final ReportService _service;

  ReportViewModel(this._service);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<Report> _reports = [];
  List<Report> get reports => _reports;

  Future<void> fetchReports() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _reports = await _service.getReports();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to load reports';
      notifyListeners();
    }
  }

  Future<bool> generateReport(String type, String format) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _service.generateReport(type, format);
      // Refresh list after generating
      await fetchReports();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to generate report';
      notifyListeners();
      return false;
    }
  }
}
