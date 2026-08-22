import 'package:ecommerce_app/features/home/models/home_section_model.dart';

abstract class HomeStates {
  const HomeStates();

  @override
  List<Object?> get props => [];
}
class HomeInitial extends HomeStates{}

class HomeLoading extends HomeStates{}

class HomeSuccess extends HomeStates{
  final List<HomeSectionModel> products;
  HomeSuccess(this.products);
}
class HomeErrorState extends HomeStates {
  final String errorMessage;
  HomeErrorState(this.errorMessage);
}

