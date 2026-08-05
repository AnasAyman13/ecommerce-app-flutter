import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/view_state.dart';
import '../models/category_model.dart';
import '../repositories/categories_repository.dart';

class CategoriesViewModel extends Cubit<ViewState<List<CategoryModel>>> {
  final CategoriesRepository _repository;

  CategoriesViewModel(this._repository) : super(const ViewState.initial());

  Future<void> loadCategories() async {
    emit(const ViewState.loading());
    try {
      emit(ViewState.success(await _repository.getCategories()));
    } catch (error) {
      emit(ViewState.failure(error.toString()));
    }
  }
}
