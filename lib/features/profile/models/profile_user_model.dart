import 'package:equatable/equatable.dart';

class ProfileUserModel extends Equatable {
  final String name;
  final String email;
  final String memberSince;
  final String badge;
  final int ordersCount;
  final int reviewsCount;
  final int savedCount;
  final String spentAmount;

  const ProfileUserModel({
    required this.name,
    required this.email,
    required this.memberSince,
    required this.badge,
    required this.ordersCount,
    required this.reviewsCount,
    required this.savedCount,
    required this.spentAmount,
  });

  @override
  List<Object> get props => [
    name,
    email,
    memberSince,
    badge,
    ordersCount,
    reviewsCount,
    savedCount,
    spentAmount,
  ];
}
