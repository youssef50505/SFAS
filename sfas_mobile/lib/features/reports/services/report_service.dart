import 'package:dio/dio.dart';
import '../../../core/constants/endpoints.dart';
import '../models/report.dart';

class ReportService {
  final Dio _dio;

  ReportService(this._dio);

  Future<List<Report>> getReports() async {
    try {
      final response = await _dio.get(Endpoints.reports);
      final List<dynamic> data = response.data;
      return data.map((json) => Report.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> generateReport(String type, String format) async {
    try {
      await _dio.post(
        Endpoints.reports,
        queryParameters: {
          'type': type,
          'format': format,
        },
      );
    } catch (e) {
      rethrow;
    }
  }
}
