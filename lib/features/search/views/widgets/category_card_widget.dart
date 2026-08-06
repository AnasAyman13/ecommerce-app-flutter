import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class CategoryCardWidget extends StatelessWidget {
  final String title;
  final String itemsCount;
  final String imageUrl;
  final double height;
  final VoidCallback onTap;

  const CategoryCardWidget({
    super.key,
    required this.title,
    required this.itemsCount,
    required this.imageUrl,
    this.height = 180,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.r),
        child: SizedBox(
          height: height.h,
          width: double.infinity,
          child: Stack(
            children: [
              Image.network(
                imageUrl,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Image.asset(
                  'assets/images/stav_oak_chair.png',
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withValues(alpha: 0.6),
                      Colors.transparent,
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                ),
              ),
              Positioned(
                bottom: 16.h,
                left: 20.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.serifHeader.copyWith(
                        color: AppColors.white,
                        fontSize: 20.sp,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      itemsCount,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 16.h,
                right: 20.w,
                child: CircleAvatar(
                  radius: 18.r,
                  backgroundColor: Colors.white.withValues(alpha: 0.3),
                  child: Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.white,
                    size: 20.sp,
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
