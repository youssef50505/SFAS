import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService;
  final FlutterSecureStorage _storage;

  AuthViewModel({
    required AuthService authService,
    required FlutterSecureStorage storage,
  })  : _authService = authService,
        _storage = storage;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  User? _currentUser;
  User? get currentUser => _currentUser;

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _authService.login(email, password);
      
      // Save token
      await _storage.write(key: 'jwt_token', value: response.token);
      
      // Save user details
      _currentUser = response.user;
      await _storage.write(key: 'user_id', value: response.user.id);
      await _storage.write(key: 'user_name', value: response.user.name);
      await _storage.write(key: 'user_email', value: response.user.email);
      await _storage.write(key: 'user_role', value: response.user.role);

      _isLoading = false;
      notifyListeners();
      return true;
    } on DioException catch (e) {
      _isLoading = false;
      if (e.response != null && e.response?.statusCode == 401) {
        _errorMessage = 'Invalid email or password';
      } else {
        _errorMessage = 'Connection error. Please try again.';
      }
      notifyListeners();
      return false;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'An unexpected error occurred.';
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    await _storage.deleteAll();
    _currentUser = null;
    notifyListeners();
  }

  Future<bool> checkAuthStatus() async {
    final token = await _storage.read(key: 'jwt_token');
    if (token != null) {
      final id = await _storage.read(key: 'user_id');
      final name = await _storage.read(key: 'user_name');
      final email = await _storage.read(key: 'user_email');
      final role = await _storage.read(key: 'user_role');
      
      if (id != null) {
        _currentUser = User(id: id, name: name ?? '', email: email ?? '', role: role ?? '');
        notifyListeners();
        return true;
      }
    }
    return false;
  }
}
