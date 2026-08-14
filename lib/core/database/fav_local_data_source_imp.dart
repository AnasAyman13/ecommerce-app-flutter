import 'package:ecommerce_app/core/database/fav_local_data_source.dart';
import 'package:ecommerce_app/core/models/favorite_item_model.dart';
import 'package:hive/hive.dart';

class FavLocalDataSourceImp implements FavLocalDataSource{
  static const String boxName = 'favorites_box';
  @override
  Future<void> addToFavorites(FavoriteItemModel item) async{
    final box = Hive.box<FavoriteItemModel>(boxName);
    await box.put(item.id, item);
  }

  @override
  List<FavoriteItemModel> getFavorites() {
    final box = Hive.box<FavoriteItemModel>(boxName);
    return box.values.toList();
  }

  @override
  bool isFavorite(int id) {
    final box = Hive.box<FavoriteItemModel>(boxName);
    return box.containsKey(id);
  }

  @override
  Future<void> removeFromFavorites(int id) async{
    final box = Hive.box<FavoriteItemModel>(boxName);
    await box.delete(id);
  }
}