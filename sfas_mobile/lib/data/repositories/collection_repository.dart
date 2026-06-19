import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../domain/models/collection.dart';

class CollectionRepository {
  final DioClient _dioClient;

  CollectionRepository(this._dioClient);

  Future<List<Collection>> getCollections() async {
    try {
      final response = await _dioClient.dio.get('/collections');
      return (response.data as List).map((json) => Collection.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data['detail'] ?? 'Failed to load collections');
    }
  }

  Future<Collection> createCollection(Map<String, dynamic> data) async {
    try {
      final response = await _dioClient.dio.post('/collections', data: data);
      return Collection.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['detail'] ?? 'Failed to create collection');
    }
  }
}
