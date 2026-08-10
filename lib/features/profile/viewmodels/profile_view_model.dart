import 'package:flutter/material.dart';
import '../models/profile_user_model.dart';

class ProfileViewModel extends ChangeNotifier {
  ProfileUserModel _user = const ProfileUserModel(
    name: 'Elina Bergström',
    email: 'elina@norr.co',
    memberSince: '2022',
    badge: '+ GOLD MEMBER',
    ordersCount: 12,
    reviewsCount: 4,
    savedCount: 28,
    spentAmount: '\$8.2k',
  );

  ProfileUserModel get user => _user;

  void updateUserProfile({String? name, String? email}) {
    _user = ProfileUserModel(
      name: name ?? _user.name,
      email: email ?? _user.email,
      memberSince: _user.memberSince,
      badge: _user.badge,
      ordersCount: _user.ordersCount,
      reviewsCount: _user.reviewsCount,
      savedCount: _user.savedCount,
      spentAmount: _user.spentAmount,
    );
    notifyListeners();
  }
}
