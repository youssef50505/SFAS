import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';

class NotificationRepository {
  final DioClient _dioClient;

  NotificationRepository(this._dioClient);

  Future<List<String>> getNotifications() async {
    try {
      final response = await _dioClient.dio.get('/notifications');
      return (response.data as List).map((item) => item.toString()).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data['detail'] ?? 'Failed to load notifications');
    }
  }
}
