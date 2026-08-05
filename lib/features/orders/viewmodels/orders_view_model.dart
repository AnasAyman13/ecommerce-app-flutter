import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/view_state.dart';
import '../models/order_model.dart';
import '../repositories/orders_repository.dart';

class OrdersViewModel extends Cubit<ViewState<List<OrderModel>>> {
  final OrdersRepository _repository;

  OrdersViewModel(this._repository) : super(const ViewState.initial());

  Future<void> loadOrders() async {
    emit(const ViewState.loading());
    try {
      emit(ViewState.success(await _repository.getOrders()));
    } catch (error) {
      emit(ViewState.failure(error.toString()));
    }
  }
}
