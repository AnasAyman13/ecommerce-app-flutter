import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/routing/app_route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_bottom_nav_bar.dart';
import '../../models/product_model.dart';

class ListingScreen extends StatefulWidget {
  final String? categoryId;

  const ListingScreen({super.key, this.categoryId});

  @override
  State<ListingScreen> createState() => _ListingScreenState();
}

class _ListingScreenState extends State<ListingScreen> {
  String _selectedCategory = 'All';

  final List<String> _categories = const [
    'All',
    'Sofas',
    'Sectionals',
    'Lounge Chairs',
    'Armchairs',
  ];

  final List<ProductModel> _products = const [
    ProductModel(
      id: 'p1',
      title: 'Bergen Sofa',
      rating: 4.8,
      price: 1840,
      originalPrice: 2200,
      imageUrl: 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=500&auto=format&fit=crop',
      isSale: true,
    ),
    ProductModel(
      id: 'p2',
      title: 'Arik Lounge Chair',
      rating: 4.6,
      price: 480,
      imageUrl: 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=500&auto=format&fit=crop',
    ),
    ProductModel(
      id: 'p3',
      title: 'Fjord Sectional',
      rating: 4.9,
      price: 2650,
      imageUrl: 'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?w=500&auto=format&fit=crop',
    ),
    ProductModel(
      id: 'p4',
      title: 'Stav Oak Chair',
      rating: 4.5,
      price: 340,
      imageUrl: 'https://images.unsplash.com/photo-1580481072645-022f9a6d8310?w=500&auto=format&fit=crop',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgCream,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 8.h),
            // Header Row
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.maybePop(context),
                    child: Container(
                      width: 42.r,
                      height: 42.r,
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
                    'Sofas & Chairs',
                    style: AppTextStyles.serifHeader.copyWith(
                      fontSize: 22.sp,
                    ),
                  ),
                  Container(
                    width: 42.r,
                    height: 42.r,
                    decoration: const BoxDecoration(
                      color: AppColors.lightPillBg,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.grid_view_rounded,
                      color: AppColors.textDark,
                      size: 20.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),

            // Horizontal Filter Pills
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: _categories.map((cat) {
                  final isSelected = _selectedCategory == cat;
                  return Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedCategory = cat),
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
                          cat,
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
            SizedBox(height: 14.h),

            // Results count & Filter/Sort Controls
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Text(
                    '142 results',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: AppColors.textGrey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  // Price sort button
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: AppColors.lightPillBg,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.swap_vert_rounded,
                          size: 16.sp,
                          color: AppColors.textDark,
                        ),
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
                  // Filter button
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: AppColors.primaryMaroon,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.tune_rounded,
                          size: 16.sp,
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
            ),
            SizedBox(height: 12.h),

            // Product Grid
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.72,
                  crossAxisSpacing: 14.w,
                  mainAxisSpacing: 14.h,
                ),
                itemCount: _products.length,
                itemBuilder: (context, index) {
                  final product = _products[index];
                  return _buildProductCard(product);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
    );
  }

  Widget _buildProductCard(ProductModel product) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRouteNames.productDetails,
          arguments: {'productId': product.id},
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Stack
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
                  child: Image.network(
                    product.imageUrl,
                    height: 150.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 150.h,
                      color: AppColors.lightPillBg,
                      child: const Icon(Icons.chair, color: AppColors.textGrey),
                    ),
                  ),
                ),
                // SALE Tag
                if (product.isSale)
                  Positioned(
                    top: 10.h,
                    left: 10.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: AppColors.primaryMaroon,
                        borderRadius: BorderRadius.circular(8.r),
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
                // Wishlist Heart Button
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

            // Info Section
            Padding(
              padding: EdgeInsets.all(12.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Rating Row
                  Row(
                    children: [
                      ...List.generate(
                        5,
                        (i) => Icon(
                          Icons.star_rounded,
                          size: 14.sp,
                          color: AppColors.starYellow,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '${product.rating}',
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: AppColors.textGrey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),

                  // Title
                  Text(
                    product.title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),

                  // Price & Strikethrough Price
                  Row(
                    children: [
                      Text(
                        product.formattedPrice,
                        style: AppTextStyles.serifPrice.copyWith(
                          fontSize: 16.sp,
                        ),
                      ),
                      if (product.formattedOriginalPrice != null) ...[
                        SizedBox(width: 6.w),
                        Text(
                          product.formattedOriginalPrice!,
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: AppColors.textLightGrey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
