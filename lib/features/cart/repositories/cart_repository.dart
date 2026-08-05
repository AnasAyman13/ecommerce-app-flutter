import '../models/cart_item_model.dart';

abstract interface class CartRepository {
  Future<List<CartItemModel>> getCart();

  Future<List<CartItemModel>> addItem(String productId, {int quantity = 1});

  Future<List<CartItemModel>> updateQuantity(String itemId, int quantity);

  Future<List<CartItemModel>> removeItem(String itemId);
}
