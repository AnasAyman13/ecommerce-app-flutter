import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/routing/app_route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/locale_controller.dart';
import '../../../../core/utils/view_state.dart';
import '../../../../core/widgets/custom_bottom_nav_bar.dart';
import '../../models/product_list_item_model.dart';
import '../../repositories/listing_repository.dart';
import '../../viewmodels/listing_view_model.dart';

class ListingScreen extends StatelessWidget {
  final String? categoryId;
  const ListingScreen({super.key, this.categoryId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ListingViewModel(sl<ListingRepository>())
            ..loadProducts(categoryId: categoryId),
      child: Scaffold(
        backgroundColor: AppColors.bgCream,
        appBar: AppBar(
          title: Text(
            categoryId == null
                ? tr(context, 'All products', 'كل المنتجات')
                : localizedCategory(context, categoryId!),
          ),
        ),
        body:
            BlocBuilder<
              ListingViewModel,
              ViewState<List<ProductListItemModel>>
            >(
              builder: (context, state) {
                if (state.status == ViewStatus.loading ||
                    state.status == ViewStatus.initial) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.status == ViewStatus.failure) {
                  return _Message(
                    message: state.errorMessage ?? 'Could not load products',
                    onRetry: () => context
                        .read<ListingViewModel>()
                        .loadProducts(categoryId: categoryId),
                  );
                }
                final products = state.data ?? const <ProductListItemModel>[];
                if (products.isEmpty)
                  return const _Message(message: 'No products found');
                return GridView.builder(
                  padding: EdgeInsets.all(16.r),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: .68,
                    crossAxisSpacing: 12.w,
                    mainAxisSpacing: 12.h,
                  ),
                  itemCount: products.length,
                  itemBuilder: (_, index) =>
                      _ProductCard(product: products[index]),
                );
              },
            ),
        bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final ProductListItemModel product;
  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: () => Navigator.pushNamed(
      context,
      AppRouteNames.productDetails,
      arguments: {'productId': product.id},
    ),
    child: Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.network(
              product.imageUrl,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  const Center(child: Icon(Icons.image_not_supported_outlined)),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localizedProductName(context, product.name),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text('EGP ${product.price.toStringAsFixed(2)}'),
                Text('★ ${product.rating.toStringAsFixed(1)}'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _Message extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  const _Message({required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(message, textAlign: TextAlign.center),
        if (onRetry != null) ...[
          const SizedBox(height: 12),
          FilledButton(onPressed: onRetry, child: const Text('Retry')),
        ],
      ],
    ),
  );
}
