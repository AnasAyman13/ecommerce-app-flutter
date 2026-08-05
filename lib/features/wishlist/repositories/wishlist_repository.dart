import '../models/wishlist_item_model.dart';

abstract interface class WishlistRepository {
  Future<List<WishlistItemModel>> getWishlist();

  Future<List<WishlistItemModel>> add(String productId);

  Future<List<WishlistItemModel>> remove(String productId);
}
