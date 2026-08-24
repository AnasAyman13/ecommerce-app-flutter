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

  factory ProductListItemModel.fromJson(Map<String, dynamic> json) {
    final price = (json['price'] as num? ?? 0).toDouble();
    final discount = (json['discountPercentage'] as num? ?? 0).toDouble();
    return ProductListItemModel(
      id: '${json['id'] ?? ''}',
      name: '${json['title'] ?? ''}',
      imageUrl: (json['thumbnail'] as String?)?.isNotEmpty == true
          ? json['thumbnail'] as String
          : ((json['images'] as List<dynamic>?)?.firstOrNull?.toString() ?? ''),
      price: price,
      oldPrice: discount > 0 ? price / (1 - discount / 100) : null,
      rating: (json['rating'] as num? ?? 0).toDouble(),
    );
  }

  @override
  List<Object?> get props => [id, name, imageUrl, price, oldPrice, rating];
}
