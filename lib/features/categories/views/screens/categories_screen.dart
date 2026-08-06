import 'package:flutter/material.dart';
import '../../../../features/search/views/screens/search_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SearchScreen(initialView: SearchSubView.categories);
  }
}
