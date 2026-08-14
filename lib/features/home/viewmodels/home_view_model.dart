import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/view_state.dart';
import '../models/home_section_model.dart';
import '../repositories/home_repository.dart';

class HomeViewModel extends Cubit<ViewState<List<HomeSectionModel>>> {
  final HomeRepository _repository;

  HomeViewModel(this._repository) : super(const ViewState.initial());

  Future<void> loadHome() async {
    emit(const ViewState.loading());
    try {
      emit(ViewState.success(await _repository.fetchProducts()));
    } catch (error) {
      emit(ViewState.failure(error.toString()));
    }
  }
}
