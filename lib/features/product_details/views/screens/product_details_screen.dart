import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/routing/app_route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String? productId;

  const ProductDetailsScreen({super.key, this.productId});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _selectedImageIndex = 0;
  int _selectedColorIndex = 0;
  bool _isFavorite = false;

  final List<String> _images = const [
    'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=800&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?w=800&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=800&auto=format&fit=crop',
  ];

  final List<Map<String, dynamic>> _colorOptions = const [
    {'name': 'Warm Caramel', 'color': Color(0xFFC59960)},
    {'name': 'Forest Green', 'color': Color(0xFF2C4A3E)},
    {'name': 'Oatmeal Bouclé', 'color': Color(0xFFE5DDD0)},
    {'name': 'Charcoal Black', 'color': Color(0xFF2B2B2B)},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgCream,
      body: SafeArea(
        child: Column(
          children: [
            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Gallery Stack
                    Stack(
                      children: [
                        SizedBox(
                          height: 320.h,
                          width: double.infinity,
                          child: PageView.builder(
                            itemCount: _images.length,
                            onPageChanged: (index) {
                              setState(() => _selectedImageIndex = index);
                            },
                            itemBuilder: (context, index) {
                              return Image.network(
                                _images[index],
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Container(
                                  color: AppColors.lightPillBg,
                                  child: const Icon(Icons.chair, size: 60, color: AppColors.textGrey),
                                ),
                              );
                            },
                          ),
                        ),

                        // Back & Actions Top Bar
                        Positioned(
                          top: 12.h,
                          left: 16.w,
                          right: 16.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.maybePop(context),
                                child: Container(
                                  width: 42.r,
                                  height: 42.r,
                                  decoration: const BoxDecoration(
                                    color: AppColors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: AppColors.textDark,
                                    size: 20.sp,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 42.r,
                                    height: 42.r,
                                    decoration: const BoxDecoration(
                                      color: AppColors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.share_outlined,
                                      color: AppColors.textDark,
                                      size: 18.sp,
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() => _isFavorite = !_isFavorite);
                                    },
                                    child: Container(
                                      width: 42.r,
                                      height: 42.r,
                                      decoration: const BoxDecoration(
                                        color: AppColors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        _isFavorite ? Icons.favorite : Icons.favorite_border,
                                        color: AppColors.primaryMaroon,
                                        size: 20.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Page Dots Indicator
                        Positioned(
                          bottom: 16.h,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(_images.length, (index) {
                              final isActive = index == _selectedImageIndex;
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                margin: EdgeInsets.symmetric(horizontal: 3.w),
                                width: isActive ? 20.w : 6.w,
                                height: 6.h,
                                decoration: BoxDecoration(
                                  color: isActive ? AppColors.primaryMaroon : AppColors.white.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),

                    // Details Card Area
                    Padding(
                      padding: EdgeInsets.all(20.r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Category tag & rating
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                                decoration: BoxDecoration(
                                  color: AppColors.lightPillBg,
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Text(
                                  'Living Room · Sofas',
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    color: AppColors.textGrey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star_rounded,
                                    color: AppColors.starYellow,
                                    size: 18.sp,
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    '4.8',
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textDark,
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    '(124 reviews)',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: AppColors.textGrey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),

                          // Product Title
                          Text(
                            'Bergen Lounge Sofa',
                            style: AppTextStyles.serifHeader.copyWith(
                              fontSize: 24.sp,
                            ),
                          ),
                          SizedBox(height: 6.h),

                          // Price
                          Row(
                            children: [
                              Text(
                                '\$1,840',
                                style: AppTextStyles.serifPriceLarge.copyWith(
                                  fontSize: 26.sp,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                '\$2,200',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: AppColors.textLightGrey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryMaroon,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Text(
                                  'SAVE 16%',
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),

                          // Color selection
                          Text(
                            'Color & Fabric',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            children: List.generate(_colorOptions.length, (index) {
                              final option = _colorOptions[index];
                              final isSelected = index == _selectedColorIndex;
                              return GestureDetector(
                                onTap: () => setState(() => _selectedColorIndex = index),
                                child: Container(
                                  margin: EdgeInsets.only(right: 12.w),
                                  padding: EdgeInsets.all(3.r),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isSelected ? AppColors.primaryMaroon : Colors.transparent,
                                      width: 2.r,
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    radius: 16.r,
                                    backgroundColor: option['color'] as Color,
                                  ),
                                ),
                              );
                            }),
                          ),
                          SizedBox(height: 20.h),

                          // Description
                          Text(
                            'Description',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            'Crafted with premium tactile bouclé fabric and solid FSC-certified Scandinavian oak, the Bergen Lounge Sofa offers unmatched ergonomic comfort and timeless Nordic elegance.',
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: AppColors.textGrey,
                              height: 1.5,
                            ),
                          ),
                          SizedBox(height: 20.h),

                          // Specifications
                          Text(
                            'Specifications',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          _buildSpecRow('Dimensions', '240W × 105D × 78H cm'),
                          _buildSpecRow('Frame', 'Solid Scandinavian Oak'),
                          _buildSpecRow('Upholstery', 'Tactile Textured Bouclé'),
                          _buildSpecRow('Assembly', 'White-glove included'),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Add to Cart Bar
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: AppColors.cardBg,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Total Price',
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: AppColors.textGrey,
                        ),
                      ),
                      Text(
                        '\$1,840',
                        style: AppTextStyles.serifPrice.copyWith(
                          fontSize: 20.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 20.w),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, AppRouteNames.cart);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        decoration: BoxDecoration(
                          color: AppColors.darkBrownPill,
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_bag_outlined,
                              color: AppColors.white,
                              size: 18.sp,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'Add to Cart',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 12.sp, color: AppColors.textGrey),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: AppColors.textDark),
          ),
        ],
      ),
    );
  }
}
