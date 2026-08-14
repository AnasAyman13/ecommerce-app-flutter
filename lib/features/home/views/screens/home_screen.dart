import 'package:ecommerce_app/features/home/views/widgets/home_hero_section_widget.dart';
import 'package:ecommerce_app/features/home/views/widgets/rooms_section_widget.dart';
import 'package:ecommerce_app/features/home/views/widgets/single_feature_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/routing/app_route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/view_state.dart';
import '../../../../core/widgets/custom_bottom_nav_bar.dart';
import '../../models/home_section_model.dart';
import '../../models/home_section_model.dart';
import '../../viewmodels/home_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  // final List<Map<String, dynamic>> _featuredProducts = const [
  //   {
  //     'id': 'p3',
  //     'title': 'Fjord Sectional',
  //     'rating': 4.9,
  //     'price': '\$2,650',
  //     'imageUrl':
  //         'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?w=500&auto=format&fit=crop',
  //     'isSale': true,
  //   },
  //   {
  //     'id': 'p4',
  //     'title': 'Stav Oak Chair',
  //     'rating': 4.5,
  //     'price': '\$340',
  //     'imageUrl':
  //         'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=500&auto=format&fit=crop',
  //     'isSale': false,
  //   },
  //   {
  //     'id': 'p1',
  //     'title': 'Bergen Sofa',
  //     'rating': 4.8,
  //     'price': '\$1,840',
  //     'imageUrl':
  //         'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=500&auto=format&fit=crop',
  //     'isSale': false,
  //   },
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgCream,
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
                            hintText: 'Search furniture, rooms...',
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
                    decoration: const BoxDecoration(color: Color(0xFF261916)),
                    child: Stack(
                      children: [
                        // Background image
                        Image.network(
                          'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=800&auto=format&fit=crop',
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Image.asset(
                            'assets/images/stav_oak_chair.png',
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        // Dark overlay gradient
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black.withValues(alpha: 0.65),
                                Colors.black.withValues(alpha: 0.2),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                        ),
                        // Text & Content
                        Positioned(
                          top: 20.h,
                          left: 20.w,
                          right: 120.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                  'NEW ARRIVAL',
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
                                'Oslo Sofa\nCollection',
                                style: AppTextStyles.serifHeader.copyWith(
                                  color: AppColors.white,
                                  fontSize: 22.sp,
                                  height: 1.15,
                                ),
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
                                        'Shop now',
                                        style: TextStyle(
                                          color: AppColors.white,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 4.w),
                                      Icon(
                                        Icons.chevron_right_rounded,
                                        color: AppColors.white,
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
                          right: 20.w,
                          child: Row(
                            children: [
                              Container(
                                width: 22.w,
                                height: 5.h,
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(3.r),
                                ),
                              ),
                              SizedBox(width: 4.w),
                              CircleAvatar(
                                radius: 2.5.r,
                                backgroundColor: Colors.white.withValues(
                                  alpha: 0.5,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              CircleAvatar(
                                radius: 2.5.r,
                                backgroundColor: Colors.white.withValues(
                                  alpha: 0.5,
                                ),
                              ),
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
                        'Browse Rooms',
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
                        'All rooms',
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
                RoomsSectionWidget(),
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
                            'Featured',
                            style: AppTextStyles.serifHeader.copyWith(
                              fontSize: 20.sp,
                            ),
                          ),
                          Text(
                            'Curated for you',
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
                        'See all',
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
              SizedBox(
                height: 245.h,
                child:BlocBuilder<HomeViewModel, ViewState<List<HomeSectionModel>>>(
                    builder: (context,state){
                      return switch(state.status){
                        ViewStatus.loading  => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        ViewStatus.failure => Center(
                          child: Text('Error In Loading Data'),
                        ),
                        ViewStatus.success => ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            itemCount: state.data?.length ?? 0,
                            itemBuilder: (context, index) {
                              final product = state.data![index];

                              return SingleFeatureCardWidget(
                                 product.title,
                                product.price,
                                product.thumbnail,
                                product.rating,
                                    () {
                                  // Navigator
                                },
                                () {
                                  // add product to fav
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
                )
                ,
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
