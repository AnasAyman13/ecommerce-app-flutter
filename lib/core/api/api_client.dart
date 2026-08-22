import 'dart:developer' as developer;

import 'package:dio/dio.dart';

import '../constants/api_endpoints.dart';
import 'dio_interceptors.dart';

class ApiClient {
  late final Dio _dio;

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.addAll([
      AppInterceptor(),
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        error: true,
        logPrint: (message) => developer.log(message.toString(), name: 'API'),
      ),
    ]);
  }

  Dio get dio => _dio;

  Future<Response<dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParams,
  }) => _dio.get(path, queryParameters: queryParams);

  Future<Response> getProducts() async {
    try {
      final response = await _dio.get(ApiEndpoints.allProducts);
      return response;
    } catch (e) {
      rethrow;
    }
  }
  Future<Response> getProductById(int id) async {
    try {
      final response = await _dio.get('$id');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response<dynamic>> post(String path, {dynamic data}) =>
      _dio.post(path, data: data);

  Future<Response<dynamic>> put(String path, {dynamic data}) =>
      _dio.put(path, data: data);

  Future<Response<dynamic>> delete(String path) => _dio.delete(path);

  /// Attach Bearer token for authenticated requests
  void setAuthToken(String token) =>
      _dio.options.headers['Authorization'] = 'Bearer $token';

  void clearAuthToken() => _dio.options.headers.remove('Authorization');
}
