import 'package:dio/dio.dart';
import '../../../core/constants/endpoints.dart';
import '../models/collection_metrics.dart';

class CollectionService {
  final Dio _dio;

  CollectionService(this._dio);

  Future<CollectionMetrics> getMetrics() async {
    try {
      final response = await _dio.get(Endpoints.collectionsMetrics);
      return CollectionMetrics.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
