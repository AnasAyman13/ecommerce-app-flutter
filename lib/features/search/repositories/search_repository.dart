import '../models/search_result_model.dart';
import '../../../core/api/api_client.dart';

class DummyJsonSearchRepository implements SearchRepository {
  final ApiClient _apiClient;

  DummyJsonSearchRepository(this._apiClient);

  @override
  Future<List<SearchResultModel>> search(String query) async {
    final response = await _apiClient.searchProducts(query);
    final products = (response.data as Map<String, dynamic>)['products'];
    const allowed = {'furniture', 'home-decoration', 'kitchen-accessories'};
    return (products as List<dynamic>? ?? const [])
        .whereType<Map<String, dynamic>>()
        .where((json) => allowed.contains(json['category']))
        .map(
          (json) => SearchResultModel(
            productId: '${json['id'] ?? ''}',
            name: '${json['title'] ?? ''}',
            imageUrl: (json['thumbnail'] as String?)?.isNotEmpty == true
                ? json['thumbnail'] as String
                : ((json['images'] as List<dynamic>?)?.firstOrNull
                          ?.toString() ??
                      ''),
            price: (json['price'] as num? ?? 0).toDouble(),
          ),
        )
        .toList();
  }
}

abstract interface class SearchRepository {
  Future<List<SearchResultModel>> search(String query);
}
