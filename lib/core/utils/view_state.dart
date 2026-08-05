import 'package:equatable/equatable.dart';

enum ViewStatus { initial, loading, success, failure }

class ViewState<T> extends Equatable {
  final ViewStatus status;
  final T? data;
  final String? errorMessage;

  const ViewState._({required this.status, this.data, this.errorMessage});

  const ViewState.initial() : this._(status: ViewStatus.initial);

  const ViewState.loading() : this._(status: ViewStatus.loading);

  const ViewState.success(T data)
    : this._(status: ViewStatus.success, data: data);

  const ViewState.failure(String message)
    : this._(status: ViewStatus.failure, errorMessage: message);

  @override
  List<Object?> get props => [status, data, errorMessage];
}
