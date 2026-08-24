import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/utils/view_state.dart';
import '../models/cart_item_model.dart';

class CartViewModel extends Cubit<ViewState<List<CartItemModel>>> {
  final List<CartItemModel> _cartItems = [];
  final SharedPreferences? _preferences;

  String? _appliedPromoCode;

  CartViewModel([this._preferences]) : super(const ViewState.success([])) {
    _restore();
  }

  Future<void> _restore() async {
    final raw = _preferences?.getString('cart_items');
    if (raw == null) return;
    final decoded = jsonDecode(raw) as List<dynamic>;
    _cartItems
      ..clear()
      ..addAll(
        decoded.whereType<Map<String, dynamic>>().map(CartItemModel.fromJson),
      );
    _emitSuccess();
  }

  Future<void> _persist() async {
    await _preferences?.setString(
      'cart_items',
      jsonEncode(_cartItems.map((item) => item.toJson()).toList()),
    );
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
    _persist();
  }

  void removeItem(String itemId) {
    _cartItems.removeWhere((item) => item.id == itemId);

    _emitSuccess();
    _persist();
  }

  void increaseQuantity(String itemId) {
    final index = _cartItems.indexWhere((item) => item.id == itemId);

    if (index == -1) return;

    _cartItems[index].quantity++;

    _emitSuccess();
    _persist();
  }

  void decreaseQuantity(String itemId) {
    final index = _cartItems.indexWhere((item) => item.id == itemId);

    if (index == -1) return;

    if (_cartItems[index].quantity > 1) {
      _cartItems[index].quantity--;
    }

    _emitSuccess();
    _persist();
  }

  void clearCart() {
    _cartItems.clear();
    _appliedPromoCode = null;

    _emitSuccess();
    _persist();
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
