import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/routing/app_route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_bottom_nav_bar.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final List<Map<String, dynamic>> _savedItems = [
    {
      'id': 'w1',
      'title': 'Arik Lounge Chair',
      'rating': 4.6,
      'price': '\$480',
      'imageUrl':
          'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=500&auto=format&fit=crop',
    },
    {
      'id': 'w2',
      'title': 'Vela Floor Lamp',
      'rating': 4.4,
      'price': '\$320',
      'imageUrl':
          'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?w=500&auto=format&fit=crop',
    },
    {
      'id': 'w3',
      'title': 'Fjord Sectional',
      'rating': 4.9,
      'price': '\$2,650',
      'imageUrl':
          'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?w=500&auto=format&fit=crop',
    },
    {
      'id': 'w4',
      'title': 'Holm Dining Table',
      'rating': 4.7,
      'price': '\$1,200',
      'imageUrl':
          'https://images.unsplash.com/photo-1617806118233-18e1de247200?w=500&auto=format&fit=crop',
    },
    {
      'id': 'w5',
      'title': 'Bergen Sofa',
      'rating': 4.8,
      'price': '\$1,840',
      'imageUrl':
          'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=500&auto=format&fit=crop',
    },
    {
      'id': 'w6',
      'title': 'Stav Oak Chair',
      'rating': 4.5,
      'price': '\$340',
      'imageUrl':
          'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=500&auto=format&fit=crop',
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

              // 1. Header Row
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'My Wishlist',
                          style: AppTextStyles.serifHeader.copyWith(
                            fontSize: 26.sp,
                            color: AppColors.textDark,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          '${_savedItems.length} pieces saved',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: AppColors.textGrey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    // Share button
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.lightPillBg,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.ios_share_rounded,
                            size: 16.sp,
                            color: AppColors.textDark,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            'Share',
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),

              // 2. Summary Banner Card (Total Saved Value)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20.r),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6E282D),
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total saved value',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.8),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            '\$7,220',
                            style: AppTextStyles.serifHeader.copyWith(
                              color: AppColors.white,
                              fontSize: 26.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      // Add all to cart button
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Added all wishlist items to cart!'),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 10.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Text(
                            'Add all to cart',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              // 3. Grid of Saved Products
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _savedItems.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.72,
                    crossAxisSpacing: 14.w,
                    mainAxisSpacing: 16.h,
                  ),
                  itemBuilder: (context, index) {
                    final item = _savedItems[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRouteNames.productDetails,
                          arguments: {'productId': item['id']},
                        );
                      },
                      child: Container(
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
                                              Image.asset(
                                        'assets/images/stav_oak_chair.png',
                                        height: double.infinity,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  // Heart Icon (Red / Filled)
                                  Positioned(
                                    top: 10.h,
                                    right: 10.w,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _savedItems.removeAt(index);
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(6.r),
                                        decoration: const BoxDecoration(
                                          color: AppColors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.favorite_rounded,
                                          size: 16.sp,
                                          color: AppColors.primaryMaroon,
                                        ),
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
                                  SizedBox(height: 3.h),
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
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 3),
    );
  }
}
