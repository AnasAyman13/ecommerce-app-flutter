import '../models/favorite_item_model.dart';

abstract class FavLocalDataSource {
  Future<void> addToFavorites(FavoriteItemModel item);
  Future<void> removeFromFavorites(int id);
  List<FavoriteItemModel> getFavorites();
  bool isFavorite(int id);
}