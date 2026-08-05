import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle serifHeader = TextStyle(
    fontSize: 22.sp,
    fontWeight: FontWeight.bold,
    fontFamily: 'serif',
    color: AppColors.textDark,
  );

  static TextStyle serifTitle = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
    fontFamily: 'serif',
    color: AppColors.textDark,
  );

  static TextStyle serifPrice = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    fontFamily: 'serif',
    color: AppColors.primaryMaroon,
  );

  static TextStyle serifPriceLarge = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    fontFamily: 'serif',
    color: AppColors.primaryMaroon,
  );

  static TextStyle heading1 = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    fontFamily: 'serif',
    color: AppColors.white,
  );

  static TextStyle bodyTextDark = TextStyle(
    fontSize: 14.sp,
    color: AppColors.textDark,
  );

  static TextStyle bodyTextWhite = TextStyle(
    fontSize: 14.sp,
    color: AppColors.white,
  );

  static TextStyle bodyTextGrey = TextStyle(
    fontSize: 13.sp,
    color: AppColors.textGrey,
  );

  static TextStyle pillActive = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  static TextStyle pillInactive = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
  );

  static TextStyle buttonText = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );
}

