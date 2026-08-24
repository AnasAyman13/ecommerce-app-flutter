import 'package:dio/dio.dart';

import '../../../../core/api/api_client.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/errors/failures.dart';
import '../models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final ApiClient _apiClient;
  final SharedPreferences _preferences;

  AuthRepository({
    required ApiClient apiClient,
    required SharedPreferences preferences,
  }) : _apiClient = apiClient,
       _preferences = preferences;

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email) ||
        password.length < 6 ||
        !RegExp(r'[A-Za-z]').hasMatch(password) ||
        !RegExp(r'\d').hasMatch(password)) {
      throw const AuthFailure(message: 'Invalid email or password');
    }
    final user = UserModel(
      id: email.toLowerCase(),
      name: email.split('@').first,
      email: email.trim().toLowerCase(),
      token: 'session-${email.hashCode}',
    );
    await _saveSession(user);
    return user;
  }

  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    if (name.trim().length < 2 ||
        !RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email) ||
        password.length < 6 ||
        !RegExp(r'[A-Za-z]').hasMatch(password) ||
        !RegExp(r'\d').hasMatch(password)) {
      throw const AuthFailure(message: 'Please enter valid account details');
    }
    final user = UserModel(
      id: email.toLowerCase(),
      name: name.trim(),
      email: email.trim().toLowerCase(),
      token: 'session-${email.hashCode}',
    );
    await _saveSession(user);
    return user;
  }

  Future<void> logout() async {
    await _preferences.remove('session_user');
    await _preferences.remove('session_email');
    _apiClient.clearAuthToken();
  }

  Future<void> _saveSession(UserModel user) async {
    await _preferences.setString('session_user', user.name);
    await _preferences.setString('session_email', user.email);
    if (user.token != null) _apiClient.setAuthToken(user.token!);
  }

  Failure _handleDioError(DioException e) {
    if (e.type == DioExceptionType.connectionError ||
        e.type == DioExceptionType.unknown) {
      return const NetworkFailure();
    }
    final statusCode = e.response?.statusCode;
    if (statusCode == 401 || statusCode == 403) {
      return const AuthFailure();
    }
    final message =
        e.response?.data?['message'] as String? ??
        e.message ??
        'Something went wrong';
    return ServerFailure(message: message, statusCode: statusCode);
  }
}
