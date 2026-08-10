import 'package:equatable/equatable.dart';

class WishlistItemModel extends Equatable {
  final String id;
  final String title;
  final double rating;
  final String price;
  final String imageUrl;

  const WishlistItemModel({
    required this.id,
    required this.title,
    required this.rating,
    required this.price,
    required this.imageUrl,
  });

  @override
  List<Object> get props => [id, title, rating, price, imageUrl];
}
