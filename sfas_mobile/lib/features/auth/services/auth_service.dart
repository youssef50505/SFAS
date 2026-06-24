import 'package:dio/dio.dart';
import '../../../core/constants/endpoints.dart';
import '../models/login_response.dart';

class AuthService {
  final Dio _dio;

  AuthService(this._dio);

  Future<LoginResponse> login(String email, String password) async {
    try {
      final response = await _dio.post(
        Endpoints.login,
        data: {
          'email': email,
          'password': password,
        },
      );
      
      return LoginResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
