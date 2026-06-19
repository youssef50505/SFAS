import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../core/security/secure_storage.dart';
import '../../domain/models/user.dart';

class AuthRepository {
  final DioClient _dioClient;
  final SecureStorage _secureStorage;

  AuthRepository(this._dioClient, this._secureStorage);

  Future<User> login(String email, String password) async {
    try {
      final response = await _dioClient.dio.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );
      
      final data = response.data;
      final token = data['token'];
      final user = User(
        id: data['userId'],
        name: data['name'],
        email: data['email'],
        role: data['role'],
      );

      await _secureStorage.saveToken(token);
      await _secureStorage.saveRole(user.role);

      return user;
    } on DioException catch (e) {
      throw Exception(e.response?.data['detail'] ?? 'Login failed');
    }
  }

  Future<void> logout() async {
    await _secureStorage.clearAll();
  }
}
