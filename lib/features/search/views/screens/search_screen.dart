import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/routing/app_route_names.dart';
import '../../../../core/utils/view_state.dart';
import '../../../../core/widgets/custom_bottom_nav_bar.dart';
import '../../models/search_result_model.dart';
import '../../repositories/search_repository.dart';
import '../../viewmodels/search_view_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchViewModel(sl<SearchRepository>()),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () =>
                Navigator.pushReplacementNamed(context, AppRouteNames.home),
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text('Search products'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _controller,
                textInputAction: TextInputAction.search,
                onSubmitted: context.read<SearchViewModel>().search,
                decoration: InputDecoration(
                  hintText: 'Search by product name',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    onPressed: () => context.read<SearchViewModel>().search(
                      _controller.text,
                    ),
                    icon: const Icon(Icons.arrow_forward),
                  ),
                ),
              ),
            ),
            Expanded(
              child:
                  BlocBuilder<
                    SearchViewModel,
                    ViewState<List<SearchResultModel>>
                  >(
                    builder: (context, state) {
                      if (state.status == ViewStatus.loading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state.status == ViewStatus.failure) {
                        return Center(
                          child: Text(state.errorMessage ?? 'Search failed'),
                        );
                      }
                      final results = state.data ?? const <SearchResultModel>[];
                      if (results.isEmpty) {
                        return const Center(
                          child: Text('Search for a product to begin'),
                        );
                      }
                      return ListView.builder(
                        itemCount: results.length,
                        itemBuilder: (_, index) {
                          final result = results[index];
                          return ListTile(
                            leading: Image.network(
                              result.imageUrl,
                              width: 56,
                              height: 56,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) =>
                                  const Icon(Icons.image_outlined),
                            ),
                            title: Text(result.name),
                            subtitle: Text(
                              'EGP ${result.price.toStringAsFixed(2)}',
                            ),
                            onTap: () => Navigator.pushNamed(
                              context,
                              AppRouteNames.productDetails,
                              arguments: {'productId': result.productId},
                            ),
                          );
                        },
                      );
                    },
                  ),
            ),
          ],
        ),
        bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
      ),
    );
  }
}
