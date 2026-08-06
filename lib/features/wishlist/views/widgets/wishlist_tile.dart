import 'package:flutter/material.dart';
import '../../models/wishlist_item_model.dart';

class WishlistTile extends StatelessWidget {
  final WishlistItemModel item;
  final VoidCallback? onRemove;

  const WishlistTile({super.key, required this.item, this.onRemove});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.title),
      subtitle: Text(item.price),
      trailing: IconButton(
        onPressed: onRemove,
        icon: const Icon(Icons.favorite),
      ),
    );
  }
}
