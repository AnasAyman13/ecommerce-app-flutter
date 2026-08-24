import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/database/fav_repository/favorites_repository.dart';
import '../models/profile_user_model.dart';

class ProfileViewModel extends ChangeNotifier {
  final SharedPreferences _preferences;
  final FavoritesRepository _favorites;

  ProfileViewModel(this._preferences, this._favorites);

  ProfileUserModel get user => ProfileUserModel(
    name: _preferences.getString('session_user') ?? 'Guest',
    email: _preferences.getString('session_email') ?? 'Not signed in',
    memberSince: '2026',
    badge: 'NORR MEMBER',
    ordersCount: _preferences.getInt('orders_count') ?? 0,
    reviewsCount: _preferences.getInt('reviews_count') ?? 0,
    savedCount: _favorites.getFavorites().length,
    spentAmount: 'EGP 0',
  );

  void updateUserProfile({String? name, String? email}) {
    if (name != null) _preferences.setString('session_user', name);
    if (email != null) _preferences.setString('session_email', email);
    notifyListeners();
  }
}
