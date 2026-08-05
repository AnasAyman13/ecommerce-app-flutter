import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/view_state.dart';
import '../models/product_details_model.dart';
import '../repositories/product_details_repository.dart';

class ProductDetailsViewModel extends Cubit<ViewState<ProductDetailsModel>> {
  final ProductDetailsRepository _repository;

  ProductDetailsViewModel(this._repository) : super(const ViewState.initial());

  Future<void> loadProduct(String productId) async {
    emit(const ViewState.loading());
    try {
      emit(ViewState.success(await _repository.getProduct(productId)));
    } catch (error) {
      emit(ViewState.failure(error.toString()));
    }
  }
}
