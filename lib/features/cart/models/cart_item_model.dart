class CartItemModel {
  final String id;
  final String title;
  final String variant;
  final double price;
  final String imageUrl;
  int quantity;

  CartItemModel({
    required this.id,
    required this.title,
    required this.variant,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'variant': variant,
    'price': price,
    'imageUrl': imageUrl,
    'quantity': quantity,
  };

  factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
    id: '${json['id'] ?? ''}',
    title: '${json['title'] ?? ''}',
    variant: '${json['variant'] ?? ''}',
    price: (json['price'] as num? ?? 0).toDouble(),
    imageUrl: '${json['imageUrl'] ?? ''}',
    quantity: (json['quantity'] as num? ?? 1).toInt(),
  );

  String get formattedPrice =>
      'EGP ${price.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
}
