import 'package:flutter/material.dart';

import '../../models/category_model.dart';

class CategoryTile extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback? onTap;

  const CategoryTile({super.key, required this.category, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: const Icon(Icons.category_outlined),
      title: Text(category.name),
    );
  }
}
