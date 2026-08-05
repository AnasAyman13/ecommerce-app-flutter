import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/view_state.dart';
import '../models/wishlist_item_model.dart';
import '../repositories/wishlist_repository.dart';

class WishlistViewModel extends Cubit<ViewState<List<WishlistItemModel>>> {
  final WishlistRepository _repository;

  WishlistViewModel(this._repository) : super(const ViewState.initial());

  Future<void> loadWishlist() => _run(_repository.getWishlist);

  Future<void> add(String productId) => _run(() => _repository.add(productId));

  Future<void> remove(String productId) =>
      _run(() => _repository.remove(productId));

  Future<void> _run(Future<List<WishlistItemModel>> Function() action) async {
    emit(const ViewState.loading());
    try {
      emit(ViewState.success(await action()));
    } catch (error) {
      emit(ViewState.failure(error.toString()));
    }
  }
}
