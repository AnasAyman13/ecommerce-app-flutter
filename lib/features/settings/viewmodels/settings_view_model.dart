import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/view_state.dart';
import '../models/app_settings_model.dart';
import '../repositories/settings_repository.dart';

class SettingsViewModel extends Cubit<ViewState<AppSettingsModel>> {
  final SettingsRepository _repository;

  SettingsViewModel(this._repository) : super(const ViewState.initial());

  Future<void> loadSettings() async {
    emit(const ViewState.loading());
    try {
      emit(ViewState.success(await _repository.getSettings()));
    } catch (error) {
      emit(ViewState.failure(error.toString()));
    }
  }

  Future<void> saveSettings(AppSettingsModel settings) async {
    emit(const ViewState.loading());
    try {
      emit(ViewState.success(await _repository.saveSettings(settings)));
    } catch (error) {
      emit(ViewState.failure(error.toString()));
    }
  }
}
