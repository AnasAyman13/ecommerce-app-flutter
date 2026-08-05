import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/view_state.dart';
import '../models/search_result_model.dart';
import '../repositories/search_repository.dart';

class SearchViewModel extends Cubit<ViewState<List<SearchResultModel>>> {
  final SearchRepository _repository;

  SearchViewModel(this._repository) : super(const ViewState.initial());

  Future<void> search(String query) async {
    if (query.trim().isEmpty) {
      emit(const ViewState.success([]));
      return;
    }
    emit(const ViewState.loading());
    try {
      emit(ViewState.success(await _repository.search(query.trim())));
    } catch (error) {
      emit(ViewState.failure(error.toString()));
    }
  }
}
