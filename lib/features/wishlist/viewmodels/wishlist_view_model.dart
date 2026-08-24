import 'package:flutter/material.dart';

import '../../../core/database/fav_repository/favorites_repository.dart';
import '../../../core/models/favorite_item_model.dart';
import '../models/wishlist_item_model.dart';

class WishlistViewModel extends ChangeNotifier {
  final FavoritesRepository _repository;

  WishlistViewModel(this._repository);

  List<WishlistItemModel> get items =>
      _repository.getFavorites().map(_map).toList();
  int get itemCount => items.length;

  String get totalSavedValue {
    final total = _repository.getFavorites().fold<double>(
      0,
      (sum, item) => sum + item.price,
    );
    return 'EGP ${total.toStringAsFixed(0)}';
  }

  WishlistItemModel _map(FavoriteItemModel item) => WishlistItemModel(
    id: '${item.id}',
    title: item.title,
    rating: item.rating,
    price: 'EGP ${item.price.toStringAsFixed(2)}',
    imageUrl: item.thumbnail,
  );

  Future<void> removeItem(int index) async {
    final current = _repository.getFavorites();
    if (index >= 0 && index < current.length) {
      await _repository.removeFromFavorites(current[index].id);
      notifyListeners();
    }
  }

  Future<void> clearAll() async {
    for (final item in _repository.getFavorites()) {
      await _repository.removeFromFavorites(item.id);
    }
    notifyListeners();
  }
}
