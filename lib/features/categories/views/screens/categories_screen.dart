import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/routing/app_route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_bottom_nav_bar.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  String _selectedPill = 'All';

  final List<String> _pills = const ['All', 'New', 'Sale', 'Bestsellers', 'Eco-Line'];

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
                  Container(
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
                ],
              ),
            ),
            SizedBox(height: 16.h),

            // Horizontal Filter Pills
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: _pills.map((pill) {
                  final isSelected = _selectedPill == pill;
                  return Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedPill = pill),
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
            SizedBox(height: 16.h),

            // Category Cards Scrollable Area
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    // Hero Card: Living Room
                    _buildCategoryCard(
                      title: 'Living Room',
                      itemCount: '142 items',
                      imageUrl: 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=800&auto=format&fit=crop',
                      height: 170.h,
                      onTap: () => _navigateToListing('living_room'),
                    ),
                    SizedBox(height: 14.h),

                    // Grid Cards: Bedroom, Chairs, Lighting, Dining
                    Row(
                      children: [
                        Expanded(
                          child: _buildCategoryCard(
                            title: 'Bedroom',
                            itemCount: '87 items',
                            imageUrl: 'https://images.unsplash.com/photo-1616594039964-ae9021a400a0?w=500&auto=format&fit=crop',
                            height: 160.h,
                            onTap: () => _navigateToListing('bedroom'),
                          ),
                        ),
                        SizedBox(width: 14.w),
                        Expanded(
                          child: _buildCategoryCard(
                            title: 'Chairs',
                            itemCount: '64 items',
                            imageUrl: 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=500&auto=format&fit=crop',
                            height: 160.h,
                            onTap: () => _navigateToListing('chairs'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 14.h),
                    Row(
                      children: [
                        Expanded(
                          child: _buildCategoryCard(
                            title: 'Lighting',
                            itemCount: '55 items',
                            imageUrl: 'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?w=500&auto=format&fit=crop',
                            height: 160.h,
                            tag: 'Preview',
                            onTap: () => _navigateToListing('lighting'),
                          ),
                        ),
                        SizedBox(width: 14.w),
                        Expanded(
                          child: _buildCategoryCard(
                            title: 'Dining',
                            itemCount: '38 items',
                            imageUrl: 'https://images.unsplash.com/photo-1617806118233-18e1de247200?w=500&auto=format&fit=crop',
                            height: 160.h,
                            onTap: () => _navigateToListing('dining'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
    );
  }

  void _navigateToListing(String categoryId) {
    Navigator.pushNamed(
      context,
      AppRouteNames.listing,
      arguments: {'categoryId': categoryId},
    );
  }

  Widget _buildCategoryCard({
    required String title,
    required String itemCount,
    required String imageUrl,
    required double height,
    required VoidCallback onTap,
    String? tag,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.r),
        child: Container(
          height: height,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: AppColors.lightPillBg,
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Image with gradient overlay
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: AppColors.lightPillBg,
                  child: const Icon(Icons.category, color: AppColors.textGrey),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.55),
                      Colors.transparent,
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                ),
              ),

              // Tag if present
              if (tag != null)
                Positioned(
                  top: 12.h,
                  left: 12.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      tag,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

              // Title and Item Count
              Positioned(
                bottom: 14.h,
                left: 14.w,
                right: 50.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'serif',
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      itemCount,
                      style: TextStyle(
                        color: AppColors.white.withOpacity(0.85),
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
              ),

              // Arrow button
              Positioned(
                bottom: 12.h,
                right: 12.w,
                child: Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.white,
                    size: 18.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
