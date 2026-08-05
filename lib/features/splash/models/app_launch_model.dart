import 'package:equatable/equatable.dart';

class AppLaunchModel extends Equatable {
  final bool isAuthenticated;
  final bool hasCompletedOnboarding;

  const AppLaunchModel({
    required this.isAuthenticated,
    required this.hasCompletedOnboarding,
  });

  @override
  List<Object> get props => [isAuthenticated, hasCompletedOnboarding];
}
