import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle heading1 = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    fontFamily: 'Serif',
    color: AppColors.white,
  );

  static TextStyle bodyTextWhite = TextStyle(
    fontSize: 14.sp,
    color: AppColors.white,
  );

  static TextStyle bodyTextDark = TextStyle(
    fontSize: 14.sp,
    color: AppColors.darkBrown,
  );

  static TextStyle buttonText = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.2,
    color: AppColors.white,
  );
}