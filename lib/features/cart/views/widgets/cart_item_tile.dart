import 'package:flutter/material.dart';
import '../../models/cart_item_model.dart';

class CartItemTile extends StatelessWidget {
  final CartItemModel item;
  final VoidCallback? onRemove;

  const CartItemTile({super.key, required this.item, this.onRemove});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.title),
      subtitle: Text('${item.quantity} × ${item.formattedPrice}'),
      trailing: IconButton(
        onPressed: onRemove,
        icon: const Icon(Icons.delete_outline),
      ),
    );
  }
}
