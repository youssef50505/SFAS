import 'package:dio/dio.dart';
import '../../../core/constants/endpoints.dart';
import '../models/vendor.dart';

class VendorService {
  final Dio _dio;

  VendorService(this._dio);

  Future<List<Vendor>> getVendors() async {
    try {
      final response = await _dio.get(Endpoints.vendors);
      final List<dynamic> data = response.data;
      return data.map((json) => Vendor.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<Vendor> createVendor(Vendor vendor) async {
    try {
      final response = await _dio.post(
        Endpoints.vendors,
        data: vendor.toJson(),
      );
      return Vendor.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Vendor> updateVendor(String id, Vendor vendor) async {
    try {
      final response = await _dio.put(
        Endpoints.vendorDetails(id),
        data: vendor.toJson(),
      );
      return Vendor.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteVendor(String id) async {
    try {
      await _dio.delete(Endpoints.vendorDetails(id));
    } catch (e) {
      rethrow;
    }
  }
}
