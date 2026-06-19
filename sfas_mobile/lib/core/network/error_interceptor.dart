import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      print('HTTP Error: ${err.response?.statusCode} -> ${err.requestOptions.path}');
    }
    
    // Check for 401 Unauthorized
    if (err.response?.statusCode == 401) {
      // Typically trigger stream/bloc event here to log out user
      // and clear secure storage.
      if (kDebugMode) {
        print('Unauthorized. Session expired.');
      }
    }

    super.onError(err, handler);
  }
}
