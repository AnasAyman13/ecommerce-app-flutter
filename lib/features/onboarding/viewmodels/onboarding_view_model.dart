import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/view_state.dart';
import '../models/onboarding_page_model.dart';
import '../repositories/onboarding_repository.dart';

class OnboardingViewModel extends Cubit<ViewState<List<OnboardingPageModel>>> {
  final OnboardingRepository _repository;

  OnboardingViewModel(this._repository) : super(const ViewState.initial());

  Future<void> completeOnboarding() async {
    emit(ViewState.loading());
    try {
      await _repository.isOnboardingVisited();
      emit(ViewState.success([]));
    } catch (error) {
      emit(ViewState.failure(error.toString()));
    }
  }
  // Future<void> loadPages() async {
  //   emit(const ViewState.loading());
  //   try {
  //     emit(ViewState.success(await _repository.getPages()));
  //   } catch (error) {
  //     emit(ViewState.failure(error.toString()));
  //   }
  // }

  // Future<void> complete() => _repository.completeOnboarding();
}
