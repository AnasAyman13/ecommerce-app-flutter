import '../models/product_list_item_model.dart';
import '../../../core/api/api_client.dart';

class DummyJsonListingRepository implements ListingRepository {
  final ApiClient _apiClient;

  DummyJsonListingRepository(this._apiClient);

  @override
  Future<List<ProductListItemModel>> getProducts({
    String? categoryId,
    int page = 1,
  }) async {
    const allowed = ['furniture', 'home-decoration', 'kitchen-accessories'];
    final responses = categoryId == null
        ? await Future.wait(
            allowed.map(
              (category) => _apiClient.getProducts(
                category: category,
                skip: (page - 1) * 30,
                limit: 100,
              ),
            ),
          )
        : [
            await _apiClient.getProducts(
              category: categoryId,
              skip: (page - 1) * 30,
              limit: 100,
            ),
          ];
    final products = responses.expand(
      (response) =>
          ((response.data as Map<String, dynamic>)['products']
              as List<dynamic>? ??
          const []),
    );
    return products
        .whereType<Map<String, dynamic>>()
        .map(ProductListItemModel.fromJson)
        .toList();
  }
}

abstract interface class ListingRepository {
  Future<List<ProductListItemModel>> getProducts({
    String? categoryId,
    int page = 1,
  });
}
