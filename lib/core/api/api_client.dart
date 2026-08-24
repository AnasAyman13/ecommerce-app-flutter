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

  Future<Response<dynamic>> getProducts({
    int limit = 30,
    int skip = 0,
    String? category,
  }) => _dio.get(
    category == null
        ? ApiEndpoints.allProducts
        : ApiEndpoints.productsByCategory(category),
    queryParameters: {'limit': limit, 'skip': skip},
  );

  Future<Response<dynamic>> getProductById(String id) =>
      _dio.get(ApiEndpoints.productById(id));

  Future<Response<dynamic>> getCategories() =>
      _dio.get(ApiEndpoints.productCategories);

  Future<Response<dynamic>> searchProducts(String query) =>
      _dio.get(ApiEndpoints.searchProducts, queryParameters: {'q': query});

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
