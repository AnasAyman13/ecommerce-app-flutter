import 'package:equatable/equatable.dart';

class ProductDetailsModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final List<String> imageUrls;
  final double price;
  final bool inStock;

  const ProductDetailsModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrls,
    required this.price,
    required this.inStock,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) =>
      ProductDetailsModel(
        id: '${json['id'] ?? ''}',
        name: '${json['title'] ?? ''}',
        description: '${json['description'] ?? ''}',
        imageUrls:
            (json['images'] as List<dynamic>?)
                ?.map((image) => image.toString())
                .toList() ??
            const [],
        price: (json['price'] as num? ?? 0).toDouble(),
        inStock: (json['stock'] as num? ?? 0) > 0,
      );

  @override
  List<Object> get props => [id, name, description, imageUrls, price, inStock];
}
