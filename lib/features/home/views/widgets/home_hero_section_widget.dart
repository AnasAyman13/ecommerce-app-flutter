import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class HomeHeroSectionWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}