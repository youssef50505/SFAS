import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../domain/models/vendor.dart';

class VendorRepository {
  final DioClient _dioClient;

  VendorRepository(this._dioClient);

  Future<List<Vendor>> getVendors() async {
    try {
      final response = await _dioClient.dio.get('/vendors');
      return (response.data as List).map((json) => Vendor.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data['detail'] ?? 'Failed to load vendors');
    }
  }

  Future<Vendor> createVendor(Map<String, dynamic> data) async {
    try {
      final response = await _dioClient.dio.post('/vendors', data: data);
      return Vendor.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['detail'] ?? 'Failed to create vendor');
    }
  }
}
