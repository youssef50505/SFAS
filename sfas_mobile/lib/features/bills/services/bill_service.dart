import 'package:dio/dio.dart';
import '../../../core/constants/endpoints.dart';
import '../models/bill.dart';

class BillService {
  final Dio _dio;

  BillService(this._dio);

  Future<List<Bill>> getBills() async {
    try {
      final response = await _dio.get(Endpoints.bills);
      final List<dynamic> data = response.data;
      return data.map((json) => Bill.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<Bill> createBill(Bill bill) async {
    try {
      final response = await _dio.post(
        Endpoints.bills,
        data: bill.toJson(),
      );
      return Bill.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Bill> updateBill(String id, Bill bill) async {
    try {
      final response = await _dio.put(
        Endpoints.billDetails(id),
        data: bill.toJson(),
      );
      return Bill.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteBill(String id) async {
    try {
      await _dio.delete(Endpoints.billDetails(id));
    } catch (e) {
      rethrow;
    }
  }

  Future<Bill> updateBillStatus(String id, String status) async {
    try {
      final response = await _dio.patch(
        Endpoints.updateBillStatus(id),
        queryParameters: {'status': status},
      );
      return Bill.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
