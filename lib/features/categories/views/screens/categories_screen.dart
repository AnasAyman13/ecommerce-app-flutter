import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routing/app_route_names.dart';
import '../../../../core/utils/view_state.dart';
import '../../models/category_model.dart';
import '../../viewmodels/categories_view_model.dart';
import '../../../../core/theme/locale_controller.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr(context, 'Categories', 'التصنيفات'))),
      body: BlocBuilder<CategoriesViewModel, ViewState<List<CategoryModel>>>(
        builder: (context, state) {
          if (state.status == ViewStatus.loading ||
              state.status == ViewStatus.initial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == ViewStatus.failure) {
            return Center(
              child: Text(state.errorMessage ?? 'Failed to load categories'),
            );
          }
          final categories = state.data ?? const <CategoryModel>[];
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: categories.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (_, index) => ListTile(
              title: Text(localizedCategory(context, categories[index].name)),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.pushNamed(
                context,
                AppRouteNames.listing,
                arguments: {'categoryId': categories[index].id},
              ),
            ),
          );
        },
      ),
    );
  }
}
