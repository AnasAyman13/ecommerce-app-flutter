import '../models/product_details_model.dart';
import '../../../core/api/api_client.dart';

class DummyJsonProductDetailsRepository implements ProductDetailsRepository {
  final ApiClient _apiClient;

  DummyJsonProductDetailsRepository(this._apiClient);

  @override
  Future<ProductDetailsModel> getProduct(String productId) async {
    final response = await _apiClient.getProductById(productId);
    return ProductDetailsModel.fromJson(response.data as Map<String, dynamic>);
  }
}

abstract interface class ProductDetailsRepository {
  Future<ProductDetailsModel> getProduct(String productId);
}
