import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/view_state.dart';
import '../models/cart_item_model.dart';
import '../repositories/cart_repository.dart';

class CartViewModel extends Cubit<ViewState<List<CartItemModel>>> {
  final CartRepository _repository;

  CartViewModel(this._repository) : super(const ViewState.initial());

  Future<void> loadCart() => _run(_repository.getCart);

  Future<void> addItem(String productId, {int quantity = 1}) =>
      _run(() => _repository.addItem(productId, quantity: quantity));

  Future<void> updateQuantity(String itemId, int quantity) =>
      _run(() => _repository.updateQuantity(itemId, quantity));

  Future<void> removeItem(String itemId) =>
      _run(() => _repository.removeItem(itemId));

  Future<void> _run(Future<List<CartItemModel>> Function() action) async {
    emit(const ViewState.loading());
    try {
      emit(ViewState.success(await action()));
    } catch (error) {
      emit(ViewState.failure(error.toString()));
    }
  }
}
