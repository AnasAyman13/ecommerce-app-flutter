import 'package:hive/hive.dart';

part 'favorite_item_model.g.dart';

@HiveType(typeId: 0)
class FavoriteItemModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(3)
  final double price;

  @HiveField(5)
  final double rating;

  @HiveField(10)
  final String thumbnail;

  @HiveField(11)
  final String availabilityStatus;

  FavoriteItemModel({
    required this.id,
    required this.title,
    required this.price,
    required this.rating,
    required this.thumbnail,
    required this.availabilityStatus,
  });
}
