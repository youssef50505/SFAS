import 'package:dio/dio.dart';
import '../../../core/constants/endpoints.dart';
import '../models/fund.dart';

class FundService {
  final Dio _dio;

  FundService(this._dio);

  Future<List<Fund>> getFunds() async {
    try {
      final response = await _dio.get(Endpoints.funds);
      final List<dynamic> data = response.data;
      return data.map((json) => Fund.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<Fund> createFund(Fund fund) async {
    try {
      final response = await _dio.post(
        Endpoints.funds,
        data: fund.toJson(),
      );
      return Fund.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Fund> updateFundStatus(String id, String status) async {
    try {
      final response = await _dio.patch(
        Endpoints.updateFundStatus(id),
        queryParameters: {'status': status},
      );
      return Fund.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
