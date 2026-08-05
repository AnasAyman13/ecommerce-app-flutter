import 'package:equatable/equatable.dart';

class ProductListItemModel extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final double? oldPrice;
  final double rating;

  const ProductListItemModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    this.oldPrice,
    this.rating = 0,
  });

  @override
  List<Object?> get props => [id, name, imageUrl, price, oldPrice, rating];
}
