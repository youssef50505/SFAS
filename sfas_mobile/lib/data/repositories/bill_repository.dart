import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../domain/models/bill.dart';

class BillRepository {
  final DioClient _dioClient;

  BillRepository(this._dioClient);

  Future<List<Bill>> getBills() async {
    try {
      final response = await _dioClient.dio.get('/bills');
      return (response.data as List).map((json) => Bill.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data['detail'] ?? 'Failed to load bills');
    }
  }

  Future<Bill> createBill(Map<String, dynamic> data) async {
    try {
      final response = await _dioClient.dio.post('/bills', data: data);
      return Bill.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['detail'] ?? 'Failed to create bill');
    }
  }

  Future<Bill> updateBillStatus(String id, String status, {String? reviewComments}) async {
    try {
      final Map<String, dynamic> data = {'status': status};
      if (reviewComments != null && reviewComments.isNotEmpty) {
        data['reviewComments'] = reviewComments;
      }
      final response = await _dioClient.dio.patch(
        '/bills/$id/status',
        data: data,
      );
      return Bill.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['detail'] ?? 'Failed to update bill status');
    }
  }
}
