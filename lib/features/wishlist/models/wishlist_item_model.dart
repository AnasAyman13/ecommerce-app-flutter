import 'package:equatable/equatable.dart';

class WishlistItemModel extends Equatable {
  final String productId;
  final String name;
  final String imageUrl;
  final double price;

  const WishlistItemModel({
    required this.productId,
    required this.name,
    required this.imageUrl,
    required this.price,
  });

  @override
  List<Object> get props => [productId, name, imageUrl, price];
}
