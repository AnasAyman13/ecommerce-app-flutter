import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/view_state.dart';
import '../models/cart_item_model.dart';

class CartViewModel extends Cubit<ViewState<List<CartItemModel>>> {
  final List<CartItemModel> _cartItems = [];

  String? _appliedPromoCode;

  CartViewModel() : super(const ViewState.initial()) {
    _cartItems.addAll([
      CartItemModel(
        id: '1',
        title: 'Bergen Lounge Sofa',
        variant: 'Warm Caramel · Bouclé',
        price: 1840,
        imageUrl:
            'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=500&auto=format&fit=crop',
        quantity: 1,
      ),
      CartItemModel(
        id: '2',
        title: 'Stav Oak Chair',
        variant: 'Natural Oak · Set of 2',
        price: 680,
        imageUrl:
            'https://images.unsplash.com/photo-1580481072645-022f9a6d8310?w=500&auto=format&fit=crop',
        quantity: 2,
      ),
    ]);

    _emitSuccess();
  }

  List<CartItemModel> get cartItems => List.unmodifiable(_cartItems);

  int get totalItemCount {
    return _cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  double get subtotal {
    return _cartItems.fold(
      0.0,
      (sum, item) => sum + (item.price * item.quantity),
    );
  }

  double get promoDiscount {
    if (_appliedPromoCode == 'NORR15') {
      return subtotal * 0.15;
    }

    return 0.0;
  }

  double get estimatedTax {
    return (subtotal - promoDiscount) * 0.10;
  }

  double get grandTotal {
    return subtotal - promoDiscount + estimatedTax;
  }

  bool get isEmpty => _cartItems.isEmpty;

  void addItem(CartItemModel item) {
    final index = _cartItems.indexWhere((cartItem) => cartItem.id == item.id);

    if (index != -1) {
      _cartItems[index].quantity++;
    } else {
      _cartItems.add(item);
    }

    _emitSuccess();
  }

  void removeItem(String itemId) {
    _cartItems.removeWhere((item) => item.id == itemId);

    _emitSuccess();
  }

  void increaseQuantity(String itemId) {
    final index = _cartItems.indexWhere((item) => item.id == itemId);

    if (index == -1) return;

    _cartItems[index].quantity++;

    _emitSuccess();
  }

  void decreaseQuantity(String itemId) {
    final index = _cartItems.indexWhere((item) => item.id == itemId);

    if (index == -1) return;

    if (_cartItems[index].quantity > 1) {
      _cartItems[index].quantity--;
    }

    _emitSuccess();
  }

  void clearCart() {
    _cartItems.clear();
    _appliedPromoCode = null;

    _emitSuccess();
  }

  bool applyPromoCode(String code) {
    final promoCode = code.trim().toUpperCase();

    if (promoCode == 'NORR15') {
      _appliedPromoCode = promoCode;
      _emitSuccess();
      return true;
    }

    return false;
  }

  void removePromoCode() {
    _appliedPromoCode = null;
    _emitSuccess();
  }

  void _emitSuccess() {
    final updatedItems = _cartItems.map((item) {
      return CartItemModel(
        id: item.id,
        title: item.title,
        variant: item.variant,
        price: item.price,
        imageUrl: item.imageUrl,
        quantity: item.quantity,
      );
    }).toList();

    emit(ViewState.success(updatedItems));
  }
}
