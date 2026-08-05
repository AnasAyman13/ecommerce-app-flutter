import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/errors/failures.dart';
import '../../../core/utils/view_state.dart';
import '../models/user_model.dart';
import '../repositories/auth_repository.dart';

class AuthViewModel extends Cubit<ViewState<UserModel?>> {
  final AuthRepository _repository;

  AuthViewModel(this._repository) : super(const ViewState.initial());

  Future<void> login({required String email, required String password}) async {
    emit(const ViewState.loading());
    try {
      final user = await _repository.login(email: email, password: password);
      emit(ViewState.success(user));
    } catch (error) {
      emit(ViewState.failure(_messageOf(error)));
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(const ViewState.loading());
    try {
      final user = await _repository.register(
        name: name,
        email: email,
        password: password,
      );
      emit(ViewState.success(user));
    } catch (error) {
      emit(ViewState.failure(_messageOf(error)));
    }
  }

  Future<void> logout() async {
    emit(const ViewState.loading());
    try {
      await _repository.logout();
      emit(const ViewState.success(null));
    } catch (error) {
      emit(ViewState.failure(_messageOf(error)));
    }
  }

  String _messageOf(Object error) =>
      error is Failure ? error.message : error.toString();
}
