import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/view_state.dart';
import '../models/app_launch_model.dart';
import '../repositories/splash_repository.dart';

class SplashViewModel extends Cubit<ViewState<AppLaunchModel>> {
  final SplashRepository _repository;

  SplashViewModel(this._repository) : super(const ViewState.initial());

  Future<void> initialize() async {
    emit(const ViewState.loading());
    try {
      emit(ViewState.success(await _repository.getLaunchState()));
    } catch (error) {
      emit(ViewState.failure(error.toString()));
    }
  }
}
