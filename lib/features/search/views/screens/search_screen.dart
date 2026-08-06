import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/routing/app_route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_bottom_nav_bar.dart';
import '../../viewmodels/search_view_model.dart';
import '../widgets/category_card_widget.dart';
import '../widgets/search_listing_product_card.dart';
import '../widgets/search_suggestion_tile.dart';
import '../widgets/trending_search_tile.dart';

class SearchScreen extends StatefulWidget {
  final SearchSubView initialView;
  final String? initialCategory;

  const SearchScreen({
    super.key,
    this.initialView = SearchSubView.categories,
    this.initialCategory,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final SearchViewModel _viewModel;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _viewModel = SearchViewModel();
    _viewModel.setInitialView(widget.initialView, widget.initialCategory);
    _viewModel.addListener(_onViewModelChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _viewModel.removeListener(_onViewModelChanged);
    _viewModel.dispose();
    super.dispose();
  }

  void _onViewModelChanged() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgCream,
      body: SafeArea(
        child: PopScope(
          canPop: _viewModel.currentView == SearchSubView.categories,
          onPopInvokedWithResult: (didPop, result) {
            if (!didPop) {
              if (_viewModel.currentView == SearchSubView.listing) {
                _viewModel.openDiscover();
              } else if (_viewModel.currentView == SearchSubView.discover) {
                _viewModel.openCategories();
              }
            }
          },
          child: IndexedStack(
            index: _viewModel.currentView.index,
            children: [
              _buildCategoriesView(),
              _buildDiscoverView(),
              _buildListingView(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
    );
  }

  Widget _buildCategoriesView() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Shop by',
                      style: AppTextStyles.serifHeader.copyWith(
                        fontSize: 26.sp,
                        color: AppColors.textDark,
                        height: 1.1,
                      ),
                    ),
                    Text(
                      'Category',
                      style: AppTextStyles.serifHeader.copyWith(
                        fontSize: 26.sp,
                        color: AppColors.primaryMaroon,
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: _viewModel.openDiscover,
                  child: Container(
                    width: 44.r,
                    height: 44.r,
                    decoration: const BoxDecoration(
                      color: AppColors.lightPillBg,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.search_rounded,
                      color: AppColors.textDark,
                      size: 22.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: _viewModel.categoryPills.map((pill) {
                final isSelected = _viewModel.selectedCategoryPill == pill;
                return Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: GestureDetector(
                    onTap: () => _viewModel.selectCategoryPill(pill),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.darkBrownPill
                            : AppColors.lightPillBg,
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      child: Text(
                        pill,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: isSelected
                              ? AppColors.white
                              : AppColors.textDark,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 18.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                CategoryCardWidget(
                  title: _viewModel.categories[0].title,
                  itemsCount: _viewModel.categories[0].itemsCount,
                  imageUrl: _viewModel.categories[0].imageUrl,
                  onTap: () => _viewModel.openListing(_viewModel.categories[0].title),
                ),
                SizedBox(height: 14.h),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _viewModel.categories.length - 1,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.15,
                    crossAxisSpacing: 14.w,
                    mainAxisSpacing: 14.h,
                  ),
                  itemBuilder: (context, index) {
                    final item = _viewModel.categories[index + 1];
                    return CategoryCardWidget(
                      title: item.title,
                      itemsCount: item.itemsCount,
                      imageUrl: item.imageUrl,
                      height: 120,
                      onTap: () => _viewModel.openListing(item.title),
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _buildDiscoverView() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h),
          Row(
            children: [
              GestureDetector(
                onTap: _viewModel.openCategories,
                child: Container(
                  width: 40.r,
                  height: 40.r,
                  decoration: const BoxDecoration(
                    color: AppColors.lightPillBg,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_back,
                    color: AppColors.textDark,
                    size: 20.sp,
                  ),
                ),
              ),
              SizedBox(width: 14.w),
              Text(
                'Discover',
                style: AppTextStyles.serifHeader.copyWith(
                  fontSize: 28.sp,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Container(
            height: 52.h,
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(26.r),
              border: Border.all(
                color: AppColors.primaryMaroon,
                width: 1.5.r,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.search_rounded,
                  color: AppColors.primaryMaroon,
                  size: 22.sp,
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onSubmitted: (query) {
                      if (query.isNotEmpty) _viewModel.openListing(query);
                    },
                    decoration: const InputDecoration(
                      hintText: 'scandinavian sofa...',
                      hintStyle: TextStyle(
                        color: AppColors.textGrey,
                        fontSize: 14,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                    style: const TextStyle(
                      color: AppColors.textDark,
                      fontSize: 14,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: const BoxDecoration(
                    color: AppColors.lightPillBg,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.mic_outlined,
                    color: AppColors.textDark,
                    size: 18.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                SearchSuggestionTile(
                  prefix: 'scandinavian',
                  suffix: 'sofa beige',
                  onTap: () => _viewModel.openListing('Scandinavian Sofa'),
                ),
                const Divider(height: 1, indent: 16, endIndent: 16),
                SearchSuggestionTile(
                  prefix: 'scandinavian',
                  suffix: 'dining table',
                  onTap: () => _viewModel.openListing('Dining Table'),
                ),
                const Divider(height: 1, indent: 16, endIndent: 16),
                SearchSuggestionTile(
                  prefix: 'scandinavian',
                  suffix: 'armchair oak',
                  onTap: () => _viewModel.openListing('Armchair Oak'),
                ),
              ],
            ),
          ),
          SizedBox(height: 22.h),
          Text(
            'RECENT SEARCHES',
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.textGrey,
              letterSpacing: 0.8,
            ),
          ),
          SizedBox(height: 10.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: _viewModel.recentSearches.map((term) {
              return GestureDetector(
                onTap: () => _viewModel.openListing(term),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.lightPillBg,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        size: 14.sp,
                        color: AppColors.textGrey,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        term,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 24.h),
          Text(
            'TRENDING NOW',
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.textGrey,
              letterSpacing: 0.8,
            ),
          ),
          SizedBox(height: 10.h),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _viewModel.trendingSearches.length,
            separatorBuilder: (context, index) =>
                const Divider(height: 16, color: Colors.black12),
            itemBuilder: (context, index) {
              final item = _viewModel.trendingSearches[index];
              return TrendingSearchTile(
                number: item.number,
                title: item.title,
                isHot: item.isHot,
                onTap: () => _viewModel.openListing(item.title),
              );
            },
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _buildListingView() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: _viewModel.openDiscover,
                  child: Container(
                    width: 40.r,
                    height: 40.r,
                    decoration: const BoxDecoration(
                      color: AppColors.lightPillBg,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.arrow_back,
                      color: AppColors.textDark,
                      size: 20.sp,
                    ),
                  ),
                ),
                Text(
                  _viewModel.selectedCategoryTitle,
                  style: AppTextStyles.serifHeader.copyWith(
                    fontSize: 22.sp,
                    color: AppColors.textDark,
                  ),
                ),
                Container(
                  width: 40.r,
                  height: 40.r,
                  decoration: const BoxDecoration(
                    color: AppColors.lightPillBg,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.grid_view_rounded,
                    color: AppColors.textDark,
                    size: 18.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 14.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: ['All', 'Sofas', 'Sectionals', 'Lounge Chairs', 'Ottomans']
                  .map((sub) {
                final isSelected = sub == 'All';
                return Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 18.w,
                      vertical: 9.h,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.darkBrownPill
                          : AppColors.lightPillBg,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      sub,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? AppColors.white : AppColors.textDark,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '142 results',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textGrey,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.lightPillBg,
                        borderRadius: BorderRadius.circular(18.r),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.swap_vert_rounded, size: 14.sp),
                          SizedBox(width: 4.w),
                          Text(
                            'Price',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryMaroon,
                        borderRadius: BorderRadius.circular(18.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.tune_rounded,
                            size: 14.sp,
                            color: AppColors.white,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            'Filter',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.72,
                crossAxisSpacing: 14.w,
                mainAxisSpacing: 16.h,
              ),
              itemBuilder: (context, index) {
                final products = [
                  {
                    'id': 'p1',
                    'title': 'Bergen Sofa',
                    'rating': 4.8,
                    'price': '\$1,840',
                    'oldPrice': '\$2,200',
                    'imageUrl':
                        'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=500&auto=format&fit=crop',
                    'isSale': true,
                  },
                  {
                    'id': 'p2',
                    'title': 'Arik Lounge Chair',
                    'rating': 4.6,
                    'price': '\$480',
                    'imageUrl':
                        'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=500&auto=format&fit=crop',
                    'isSale': false,
                  },
                  {
                    'id': 'p3',
                    'title': 'Fjord Sectional',
                    'rating': 4.9,
                    'price': '\$2,650',
                    'imageUrl':
                        'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?w=500&auto=format&fit=crop',
                    'isSale': false,
                  },
                  {
                    'id': 'p4',
                    'title': 'Stav Oak Chair',
                    'rating': 4.5,
                    'price': '\$340',
                    'imageUrl':
                        'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=500&auto=format&fit=crop',
                    'isSale': false,
                  },
                ];
                final item = products[index];
                return SearchListingProductCard(
                  item: item,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRouteNames.productDetails,
                      arguments: {'productId': item['id']},
                    );
                  },
                );
              },
            ),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
