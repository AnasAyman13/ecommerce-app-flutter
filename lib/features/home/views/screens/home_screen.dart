import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/routing/app_route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedRoomIndex = 0;

  final List<Map<String, String>> _rooms = const [
    {
      'name': 'Sofas',
      'image':
          'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=300&auto=format&fit=crop',
    },
    {
      'name': 'Chairs',
      'image':
          'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=300&auto=format&fit=crop',
    },
    {
      'name': 'Tables',
      'image':
          'https://images.unsplash.com/photo-1617806118233-18e1de247200?w=300&auto=format&fit=crop',
    },
    {
      'name': 'Lamps',
      'image':
          'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?w=300&auto=format&fit=crop',
    },
    {
      'name': 'Beds',
      'image':
          'https://images.unsplash.com/photo-1616594039964-ae9021a400a0?w=300&auto=format&fit=crop',
    },
  ];

  final List<Map<String, dynamic>> _featuredProducts = const [
    {
      'id': 'p3',
      'title': 'Fjord Sectional',
      'rating': 4.9,
      'price': '\$2,650',
      'imageUrl':
          'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?w=500&auto=format&fit=crop',
      'isSale': true,
    },
    {
      'id': 'p4',
      'title': 'Stav Oak Chair',
      'rating': 4.5,
      'price': '\$340',
      'imageUrl':
          'https://images.unsplash.com/photo-1580481072645-022f9a6d8310?w=500&auto=format&fit=crop',
      'isSale': false,
    },
    {
      'id': 'p1',
      'title': 'Bergen Sofa',
      'rating': 4.8,
      'price': '\$1,840',
      'imageUrl':
          'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=500&auto=format&fit=crop',
      'isSale': false,
    },
  ];

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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Good morning ',
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: AppColors.textGrey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Icon(
                              Icons.star,
                              size: 10.sp,
                              color: AppColors.textGrey,
                            ),
                          ],
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'Mo',
                          style: AppTextStyles.serifHeader.copyWith(
                            fontSize: 28.sp,
                            height: 1.1,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        // Bell Button
                        Container(
                          width: 44.r,
                          height: 44.r,
                          decoration: const BoxDecoration(
                            color: AppColors.lightPillBg,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.notifications_none_rounded,
                            color: AppColors.textDark,
                            size: 22.sp,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        // Profile Avatar
                        Container(
                          width: 44.r,
                          height: 44.r,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFFB8564D), Color(0xFF832C31)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              'E',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'serif',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
                              fontSize: 14.sp,
                            ),
                            border: InputBorder.none,
                            isDense: true,
                          ),
                          style: TextStyle(
                            color: AppColors.textDark,
                            fontSize: 14.sp,
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
                              Container(color: const Color(0xFF261916)),
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
              SizedBox(
                height: 120.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  itemCount: _rooms.length,
                  itemBuilder: (context, index) {
                    final room = _rooms[index];
                    final isSelected = index == _selectedRoomIndex;

                    return GestureDetector(
                      onTap: () {
                        setState(() => _selectedRoomIndex = index);
                        Navigator.pushNamed(
                          context,
                          AppRouteNames.listing,
                          arguments: {'categoryId': room['name']},
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 18.w),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(2.r),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.primaryMaroon
                                      : Colors.transparent,
                                  width: 2.r,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 30.r,
                                backgroundImage: NetworkImage(room['image']!),
                                backgroundColor: AppColors.lightPillBg,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              room['name']!,
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                                color: isSelected
                                    ? AppColors.primaryMaroon
                                    : AppColors.textGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
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
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  itemCount: _featuredProducts.length,
                  itemBuilder: (context, index) {
                    final item = _featuredProducts[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRouteNames.productDetails,
                          arguments: {'productId': item['id']},
                        );
                      },
                      child: Container(
                        width: 170.w,
                        margin: EdgeInsets.only(right: 14.w),
                        decoration: BoxDecoration(
                          color: AppColors.cardBg,
                          borderRadius: BorderRadius.circular(24.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.03),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(24.r),
                                    ),
                                    child: Image.network(
                                      item['imageUrl'] as String,
                                      height: double.infinity,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Container(
                                                color: AppColors.lightPillBg,
                                                child: const Icon(
                                                  Icons.chair,
                                                  color: AppColors.textGrey,
                                                ),
                                              ),
                                    ),
                                  ),
                                  if (item['isSale'] == true)
                                    Positioned(
                                      top: 10.h,
                                      left: 10.w,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10.w,
                                          vertical: 4.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryMaroon,
                                          borderRadius: BorderRadius.circular(
                                            8.r,
                                          ),
                                        ),
                                        child: Text(
                                          'SALE',
                                          style: TextStyle(
                                            color: AppColors.white,
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  Positioned(
                                    top: 10.h,
                                    right: 10.w,
                                    child: Container(
                                      padding: EdgeInsets.all(6.r),
                                      decoration: const BoxDecoration(
                                        color: AppColors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.favorite_border_rounded,
                                        size: 16.sp,
                                        color: AppColors.primaryMaroon,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.r),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      ...List.generate(
                                        5,
                                        (i) => Icon(
                                          Icons.star_rounded,
                                          size: 12.sp,
                                          color: AppColors.starYellow,
                                        ),
                                      ),
                                      SizedBox(width: 4.w),
                                      Text(
                                        '${item['rating']}',
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          color: AppColors.textGrey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 2.h),
                                  Text(
                                    item['title'] as String,
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textDark,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 2.h),
                                  Text(
                                    item['price'] as String,
                                    style: AppTextStyles.serifPrice.copyWith(
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
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
