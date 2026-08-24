import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/database/fav_repository/favorites_repository.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/models/favorite_item_model.dart';
import '../../../../core/utils/view_state.dart';
import '../../models/product_details_model.dart';
import '../../viewmodels/product_details_view_model.dart';
import '../../../cart/models/cart_item_model.dart';
import '../../../cart/view_models/cart_view_model.dart';
import '../../../../core/theme/locale_controller.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String? productId;
  const ProductDetailsScreen({super.key, this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product details'),
        actions: [
          BlocBuilder<CartViewModel, ViewState<List<CartItemModel>>>(
            builder: (context, state) => Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_bag_outlined),
                  onPressed: () => Navigator.pushNamed(context, '/cart'),
                ),
                if (context.read<CartViewModel>().totalItemCount > 0)
                  Positioned(
                    right: 4,
                    top: 4,
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.red,
                      child: Text(
                        '${context.read<CartViewModel>().totalItemCount}',
                        style: const TextStyle(
                          fontSize: 9,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          BlocBuilder<ProductDetailsViewModel, ViewState<ProductDetailsModel>>(
            builder: (context, state) {
              final product = state.data;
              if (product == null) return const SizedBox.shrink();
              final favorites = sl<FavoritesRepository>();
              final id = int.tryParse(product.id);
              return ValueListenableBuilder(
                valueListenable: Hive.box<FavoriteItemModel>(
                  'favorites_box',
                ).listenable(),
                builder: (context, box, _) {
                  final saved = id != null && favorites.isFavorite(id);
                  return IconButton(
                    icon: Icon(
                      saved ? Icons.favorite : Icons.favorite_border,
                      color: saved ? Colors.red : null,
                    ),
                    onPressed: id == null
                        ? null
                        : () async {
                            if (favorites.isFavorite(id)) {
                              await favorites.removeFromFavorites(id);
                            } else {
                              await favorites.addToFavorites(
                                FavoriteItemModel(
                                  id: id,
                                  title: product.name,
                                  price: product.price,
                                  rating: 0,
                                  thumbnail: product.imageUrls.isEmpty
                                      ? ''
                                      : product.imageUrls.first,
                                  availabilityStatus: product.inStock
                                      ? 'In stock'
                                      : 'Out of stock',
                                ),
                              );
                            }
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    saved
                                        ? 'Removed from wishlist'
                                        : 'Added to wishlist',
                                  ),
                                ),
                              );
                            }
                          },
                  );
                },
              );
            },
          ),
        ],
      ),
      body:
          BlocBuilder<ProductDetailsViewModel, ViewState<ProductDetailsModel>>(
            builder: (context, state) {
              if (state.status == ViewStatus.loading ||
                  state.status == ViewStatus.initial) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.status == ViewStatus.failure || state.data == null) {
                return Center(
                  child: Text(state.errorMessage ?? 'Failed to load product'),
                );
              }
              final product = state.data!;
              return ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  if (product.imageUrls.isNotEmpty)
                    AspectRatio(
                      aspectRatio: 1,
                      child: PageView(
                        children: product.imageUrls
                            .map(
                              (url) => Image.network(
                                url,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => const Icon(
                                  Icons.image_not_supported_outlined,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  const SizedBox(height: 20),
                  Text(
                    localizedProductName(context, product.name),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'EGP ${product.price.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Text(product.description),
                  const SizedBox(height: 16),
                  Chip(
                    label: Text(product.inStock ? 'In stock' : 'Out of stock'),
                  ),
                  const SizedBox(height: 20),
                  FilledButton.icon(
                    onPressed: product.inStock
                        ? () {
                            context.read<CartViewModel>().addItem(
                              CartItemModel(
                                id: product.id,
                                title: product.name,
                                variant: 'Standard',
                                price: product.price,
                                imageUrl: product.imageUrls.isEmpty
                                    ? ''
                                    : product.imageUrls.first,
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Added to cart')),
                            );
                          }
                        : null,
                    icon: const Icon(Icons.add_shopping_cart_outlined),
                    label: const Text('Add to cart'),
                  ),
                ],
              );
            },
          ),
    );
  }
}
