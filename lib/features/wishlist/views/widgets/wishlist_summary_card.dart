import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class WishlistSummaryCard extends StatelessWidget {
  final String totalValue;
  final VoidCallback onAddAllToCart;

  const WishlistSummaryCard({
    super.key,
    required this.totalValue,
    required this.onAddAllToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                totalValue,
                style: AppTextStyles.serifHeader.copyWith(
                  color: AppColors.white,
                  fontSize: 26.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: onAddAllToCart,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
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
    );
  }
}
