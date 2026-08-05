import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/view_state.dart';
import '../models/profile_model.dart';
import '../repositories/profile_repository.dart';

class ProfileViewModel extends Cubit<ViewState<ProfileModel>> {
  final ProfileRepository _repository;

  ProfileViewModel(this._repository) : super(const ViewState.initial());

  Future<void> loadProfile() async {
    emit(const ViewState.loading());
    try {
      emit(ViewState.success(await _repository.getProfile()));
    } catch (error) {
      emit(ViewState.failure(error.toString()));
    }
  }

  Future<void> updateProfile(ProfileModel profile) async {
    emit(const ViewState.loading());
    try {
      emit(ViewState.success(await _repository.updateProfile(profile)));
    } catch (error) {
      emit(ViewState.failure(error.toString()));
    }
  }
}
