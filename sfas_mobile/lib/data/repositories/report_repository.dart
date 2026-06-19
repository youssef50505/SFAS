import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../domain/models/report.dart';

class ReportRepository {
  final DioClient _dioClient;

  ReportRepository(this._dioClient);

  Future<List<Report>> getReports() async {
    try {
      final response = await _dioClient.dio.get('/reports');
      return (response.data as List).map((json) => Report.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data['detail'] ?? 'Failed to load reports');
    }
  }

  Future<Report> createReport(Map<String, dynamic> data) async {
    try {
      final response = await _dioClient.dio.post('/reports', data: data);
      return Report.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['detail'] ?? 'Failed to create report');
    }
  }
}
