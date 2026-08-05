import '../models/product_list_item_model.dart';

abstract interface class ListingRepository {
  Future<List<ProductListItemModel>> getProducts({
    String? categoryId,
    int page = 1,
  });
}
