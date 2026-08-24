import 'dart:async';
import 'package:ecommerce_app/core/models/favorite_item_model.dart';
import 'package:ecommerce_app/features/home/views/widgets/home_hero_section_widget.dart';
import 'package:ecommerce_app/features/home/views/widgets/rooms_section_widget.dart';
import 'package:ecommerce_app/features/home/views/widgets/single_feature_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/routing/app_route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/locale_controller.dart';
import '../../../../core/utils/view_state.dart';
import '../../../../core/widgets/custom_bottom_nav_bar.dart';
import '../../models/home_section_model.dart';
import '../../viewmodels/home_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _selectedCategory;
  int _bannerIndex = 0;
  Timer? _bannerTimer;
  final PageController _bannerController = PageController();
  final _bannerImages = const [
    'https://cdn.dummyjson.com/product-images/furniture/annibale-colombo-bed/thumbnail.webp',
    'https://cdn.dummyjson.com/product-images/furniture/annibale-colombo-sofa/thumbnail.webp',
    'https://cdn.dummyjson.com/product-images/furniture/bedside-table-african-cherry/thumbnail.webp',
  ];

  @override
  void initState() {
    super.initState();
    _bannerTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted) return;
      final next = (_bannerIndex + 1) % _bannerImages.length;
      _bannerController.animateToPage(
        next,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _bannerTimer?.cancel();
    _bannerController.dispose();
    super.dispose();
  }
  // Featured products are loaded from the catalog API below.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              // 1. Top Header Row (Good morning ✦ Mo / Profile)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: HomeHeroSectionWidget(),
              ),
              SizedBox(height: 16.h),

              // 2. Search Bar & Filter Button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Container(
                  height: 52.h,
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  decoration: BoxDecoration(
                    color: AppColors.lightPillBg,
                    borderRadius: BorderRadius.circular(26.r),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search_rounded,
                        color: AppColors.textGrey,
                        size: 22.sp,
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: TextField(
                          onSubmitted: (query) {
                            Navigator.pushNamed(context, AppRouteNames.listing);
                          },
                          decoration: InputDecoration(
                            hintText: tr(
                              context,
                              'Search furniture, rooms...',
                              'ابحث عن أثاث وغرف...',
                            ),
                            hintStyle: TextStyle(
                              color: AppColors.textGrey,
                              fontSize: 14,
                            ),
                            border: InputBorder.none,
                            isDense: true,
                          ),
                          style: TextStyle(
                            color: AppColors.textDark,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, AppRouteNames.listing);
                        },
                        child: Container(
                          padding: EdgeInsets.all(10.r),
                          decoration: BoxDecoration(
                            color: AppColors.primaryMaroon,
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                          child: Icon(
                            Icons.tune_rounded,
                            color: AppColors.white,
                            size: 16.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 18.h),

              // 3. Hero Banner (Oslo Sofa Collection)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24.r),
                  child: Container(
                    height: 200.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? const Color(0xFF2A2422)
                          : Colors.white,
                      border: Border.all(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? const Color(0xFF5A4B45)
                            : const Color(0xFFE8DED5),
                      ),
                    ),
                    child: Stack(
                      children: [
                        // Background image
                        PageView.builder(
                          controller: _bannerController,
                          itemCount: _bannerImages.length,
                          onPageChanged: (index) =>
                              setState(() => _bannerIndex = index),
                          itemBuilder: (_, index) => Image.network(
                            _bannerImages[index],
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.contain,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                ? const Color(0xFFC9BBB3)
                                : null,
                            colorBlendMode: BlendMode.modulate,
                            errorBuilder: (_, __, ___) => Image.asset(
                              'assets/images/stav_oak_chair.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.black.withValues(alpha: .08)
                              : Colors.white.withValues(alpha: .02),
                        ),
                        // Text & Content
                        Positioned(
                          top: 20.h,
                          left:
                              Localizations.localeOf(context).languageCode ==
                                  'ar'
                              ? null
                              : 20.w,
                          right:
                              Localizations.localeOf(context).languageCode ==
                                  'ar'
                              ? 20.w
                              : null,
                          width: 138.w,
                          child: Column(
                            crossAxisAlignment:
                                Localizations.localeOf(context).languageCode ==
                                    'ar'
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              // NEW ARRIVAL pill
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 14.w,
                                  vertical: 6.h,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFBA00),
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                child: Text(
                                  tr(context, 'NEW ARRIVAL', 'وصل حديثًا'),
                                  textAlign:
                                      Localizations.localeOf(
                                            context,
                                          ).languageCode ==
                                          'ar'
                                      ? TextAlign.right
                                      : TextAlign.left,
                                  style: TextStyle(
                                    color: AppColors.textDark,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 0.8,
                                  ),
                                ),
                              ),
                              SizedBox(height: 12.h),
                              Text(
                                tr(
                                  context,
                                  'Oslo Sofa\nCollection',
                                  'مجموعة\nأوسلو',
                                ),
                                style: AppTextStyles.serifHeader.copyWith(
                                  color: AppColors.textDark,
                                  fontSize: 22.sp,
                                  height: 1.15,
                                ),
                                textAlign:
                                    Localizations.localeOf(
                                          context,
                                        ).languageCode ==
                                        'ar'
                                    ? TextAlign.right
                                    : TextAlign.left,
                              ),
                              SizedBox(height: 14.h),
                              GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  AppRouteNames.listing,
                                ),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 8.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.25),
                                    borderRadius: BorderRadius.circular(20.r),
                                    border: Border.all(
                                      color: Colors.white.withValues(
                                        alpha: 0.4,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        tr(context, 'Shop now', 'تسوق الآن'),
                                        style: TextStyle(
                                          color: AppColors.primaryMaroon,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 4.w),
                                      Icon(
                                        Icons.chevron_right_rounded,
                                        color: AppColors.primaryMaroon,
                                        size: 16.sp,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Carousel Dots bottom right
                        Positioned(
                          bottom: 16.h,
                          right:
                              Localizations.localeOf(context).languageCode ==
                                  'ar'
                              ? 20.w
                              : null,
                          left:
                              Localizations.localeOf(context).languageCode ==
                                  'ar'
                              ? null
                              : 20.w,
                          child: Row(
                            children: [
                              ...List.generate(_bannerImages.length, (index) {
                                final active = index == _bannerIndex;
                                return AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  margin: EdgeInsets.only(left: 4.w),
                                  width: active ? 22.w : 6.w,
                                  height: 5.h,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryMaroon.withValues(
                                      alpha: active ? 1 : .5,
                                    ),
                                    borderRadius: BorderRadius.circular(3.r),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 22.h),

              // 4. Browse Rooms Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        tr(context, 'Browse Rooms', 'تصفح الغرف'),
                        style: AppTextStyles.serifHeader.copyWith(
                          fontSize: 20.sp,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(
                        context,
                        AppRouteNames.categories,
                      ),
                      child: Text(
                        tr(context, 'All rooms', 'كل الغرف'),
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: AppColors.primaryMaroon,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 14.h),

              // Rooms Horizontal Scroll List
              RoomsSectionWidget(
                onCategorySelected: (category) =>
                    setState(() => _selectedCategory = category),
              ),
              SizedBox(height: 16.h),

              // 5. Featured Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tr(context, 'Featured', 'مختارات'),
                            style: AppTextStyles.serifHeader.copyWith(
                              fontSize: 20.sp,
                            ),
                          ),
                          Text(
                            tr(context, 'Curated for you', 'مختارة لك'),
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: AppColors.textGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, AppRouteNames.listing),
                      child: Text(
                        tr(context, 'See all', 'عرض الكل'),
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: AppColors.primaryMaroon,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 14.h),

              // Featured Cards Horizontal List
              BlocBuilder<HomeViewModel, ViewState<List<HomeSectionModel>>>(
                builder: (context, state) {
                  return switch (state.status) {
                    ViewStatus.loading => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    ViewStatus.failure => Center(
                      child: Text('Error In Loading Data'),
                    ),
                    ViewStatus.success => Builder(
                      builder: (context) {
                        final products =
                            (_selectedCategory == null
                                ? state.data
                                : state.data
                                      ?.where(
                                        (product) =>
                                            product.category ==
                                            _selectedCategory,
                                      )
                                      .toList()) ??
                            const <HomeSectionModel>[];
                        if (products.isEmpty) {
                          return const Center(
                            child: Text('No products in this category'),
                          );
                        }
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12.w,
                                mainAxisSpacing: 14.h,
                                childAspectRatio: .72,
                              ),
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final product = products[index];

                            return SingleFeatureCardWidget(
                              key: ValueKey('fav_${product.id}'),
                              product.id,
                              localizedProductName(context, product.title),
                              product.price,
                              product.thumbnail,
                              product.rating,
                              context.read<HomeViewModel>().isFavorite(
                                product.id,
                              ),
                              () {
                                Navigator.pushNamed(
                                  context,
                                  AppRouteNames.productDetails,
                                  arguments: {'productId': product.id},
                                );
                              },
                              () {
                                // add product to fav
                                context.read<HomeViewModel>().toggleFavorite(
                                  product,
                                );

                                final List<FavoriteItemModel> favList = context
                                    .read<HomeViewModel>()
                                    .getFavorites();
                                print("favorite List ${favList.length}");
                              },
                            );
                          },
                        );
                      },
                    ),

                    // TODO: Handle this case.
                    ViewStatus.initial => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  };
                },
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
    );
  }
}
