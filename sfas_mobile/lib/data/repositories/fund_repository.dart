import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../domain/models/fund.dart';

class FundRepository {
  final DioClient _dioClient;

  FundRepository(this._dioClient);

  Future<List<Fund>> getFunds() async {
    try {
      final response = await _dioClient.dio.get('/funds');
      return (response.data as List).map((json) => Fund.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data['detail'] ?? 'Failed to load funds');
    }
  }

  Future<Fund> createFund(Map<String, dynamic> data) async {
    try {
      final response = await _dioClient.dio.post('/funds', data: data);
      return Fund.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['detail'] ?? 'Failed to create fund');
    }
  }

  Future<Fund> updateFundStatus(String id, String status) async {
    try {
      final response = await _dioClient.dio.patch(
        '/funds/$id/status',
        data: {'status': status},
      );
      return Fund.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['detail'] ?? 'Failed to update fund status');
    }
  }
}
