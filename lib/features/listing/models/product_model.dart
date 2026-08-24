class ProductModel {
  final String id;
  final String title;
  final double rating;
  final double price;
  final double? originalPrice;
  final String imageUrl;
  final bool isSale;
  final bool isFavorite;

  const ProductModel({
    required this.id,
    required this.title,
    required this.rating,
    required this.price,
    this.originalPrice,
    required this.imageUrl,
    this.isSale = false,
    this.isFavorite = false,
  });

  String get formattedPrice =>
      'EGP ${price.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
  String? get formattedOriginalPrice => originalPrice == null
      ? null
      : 'EGP ${originalPrice!.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
}
