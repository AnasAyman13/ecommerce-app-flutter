import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class TrendingSearchTile extends StatelessWidget {
  final String number;
  final String title;
  final bool isHot;
  final VoidCallback onTap;

  const TrendingSearchTile({
    super.key,
    required this.number,
    required this.title,
    required this.isHot,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Text(
            number,
            style: AppTextStyles.serifHeader.copyWith(
              fontSize: 18.sp,
              color: Colors.black26,
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
          ),
          if (isHot) ...[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: const Color(0xFFFBEAEB),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  Text('🔥', style: TextStyle(fontSize: 10.sp)),
                  SizedBox(width: 4.w),
                  Text(
                    'Hot',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryMaroon,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
          ],
          Icon(
            Icons.chevron_right_rounded,
            size: 18.sp,
            color: AppColors.textGrey,
          ),
        ],
      ),
    );
  }
}
