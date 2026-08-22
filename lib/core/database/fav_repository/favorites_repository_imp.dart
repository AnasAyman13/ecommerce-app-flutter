import 'package:ecommerce_app/core/database/fav_local_data_source.dart';
import 'package:ecommerce_app/core/database/fav_repository/favorites_repository.dart';
import 'package:ecommerce_app/core/models/favorite_item_model.dart';

class FavoritesRepositoryImp extends FavoritesRepository{
  final FavLocalDataSource _favLocalDataSource;

  FavoritesRepositoryImp(this._favLocalDataSource);
  @override
  Future<void> addToFavorites(FavoriteItemModel item) async{
    await _favLocalDataSource.addToFavorites(item);
  }

  @override
  List<FavoriteItemModel> getFavorites() {
    return _favLocalDataSource.getFavorites();
  }

  @override
  bool isFavorite(int id) {
    return _favLocalDataSource.isFavorite(id);
  }

  @override
  Future<void> removeFromFavorites(int id) async{
   await _favLocalDataSource.removeFromFavorites(id);
  }
}