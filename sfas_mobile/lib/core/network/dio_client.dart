import 'package:dio/dio.dart';
import 'auth_interceptor.dart';
import 'error_interceptor.dart';
import '../security/secure_storage.dart';

class DioClient {
  late final Dio dio;

  DioClient(SecureStorage secureStorage) {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://10.0.2.2:8080/api/v1', // 10.0.2.2 for Android emulator to host localhost
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.addAll([
      AuthInterceptor(secureStorage),
      ErrorInterceptor(),
      LogInterceptor(requestBody: true, responseBody: true),
    ]);
  }
}
