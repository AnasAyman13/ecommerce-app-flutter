import 'package:flutter/material.dart';

import '../../models/product_list_item_model.dart';

class ProductCard extends StatelessWidget {
  final ProductListItemModel product;
  final VoidCallback? onTap;

  const ProductCard({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        title: Text(product.name),
        subtitle: Text(product.price.toStringAsFixed(2)),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
