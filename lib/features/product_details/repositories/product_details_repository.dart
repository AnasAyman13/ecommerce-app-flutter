import '../models/product_details_model.dart';

abstract interface class ProductDetailsRepository {
  Future<ProductDetailsModel> getProduct(String productId);
}
