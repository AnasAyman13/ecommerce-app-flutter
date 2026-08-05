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

  @override
  List<Object> get props => [id, name, description, imageUrls, price, inStock];
}
