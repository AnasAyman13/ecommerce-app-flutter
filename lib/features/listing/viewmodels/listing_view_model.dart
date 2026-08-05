import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/view_state.dart';
import '../models/product_list_item_model.dart';
import '../repositories/listing_repository.dart';

class ListingViewModel extends Cubit<ViewState<List<ProductListItemModel>>> {
  final ListingRepository _repository;

  ListingViewModel(this._repository) : super(const ViewState.initial());

  Future<void> loadProducts({String? categoryId, int page = 1}) async {
    emit(const ViewState.loading());
    try {
      final products = await _repository.getProducts(
        categoryId: categoryId,
        page: page,
      );
      emit(ViewState.success(products));
    } catch (error) {
      emit(ViewState.failure(error.toString()));
    }
  }
}
