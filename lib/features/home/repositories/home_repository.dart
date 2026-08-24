import '../../../core/api/api_client.dart';
import '../models/home_section_model.dart';

class HomeRepository {
  final ApiClient _apiClient;
  HomeRepository(this._apiClient);

  Future<List<HomeSectionModel>> fetchProducts({int limit = 100}) async {
    final responses = await Future.wait([
      _apiClient.getProducts(limit: limit, category: 'furniture'),
      _apiClient.getProducts(limit: limit, category: 'home-decoration'),
      _apiClient.getProducts(limit: limit, category: 'kitchen-accessories'),
    ]);
    return responses
        .expand(
          (response) =>
              ((response.data as Map<String, dynamic>)['products']
                  as List<dynamic>? ??
              const []),
        )
        .whereType<Map<String, dynamic>>()
        .map(HomeSectionModel.fromJson)
        .where(
          (product) =>
              product.thumbnail.isNotEmpty || product.images.isNotEmpty,
        )
        .toList();
  }
}
