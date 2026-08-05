import 'dart:ffi';

import 'package:ecommerce_app/core/routing/app_route_names.dart';
import 'package:ecommerce_app/core/theme/app_text_styles.dart';
import 'package:ecommerce_app/features/onboarding/views/widgets/elevatedButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/onboardingTopSectionWidget.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OnboardingScreen();
}

class _OnboardingScreen extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Onboardingtopsectionwidget(imagePath: 'assets/images/onboarding_img.png',),
              Padding(
                padding: EdgeInsetsGeometry.all(20),
                child: SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "NORR",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.sp,
                          fontWeight: FontWeight(700),
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            AppRouteNames.home,
                            (route) => false,
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Color(0xFFFFFFFF).withAlpha(25),
                        ),
                        child: Text(
                          "Skip",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight(600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                  bottom: 40.h,
                  left: 20.w,
                  child: Column(
                    children: [
                      Text("OSLO COLLECTION",style: AppTextStyles.goldAccent11w600,)
                    ,Row(
                        children: [],
                      )
                    ],
                  ))
            ],
          ),
          Padding(
            padding: EdgeInsetsGeometry.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Designed for", style: AppTextStyles.onboardingHeadingtxt),
                Text(
                  "living beautifully",
                  style: AppTextStyles.onboardingHeadingtxt.copyWith(
                    color: AppColors.primaryMaroon,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  "Discover Scandinavian furniture that transforms your space into a sanctuary of calm, warmth, and intention.",
                  style: AppTextStyles.taupeGrey15w400,
                ),
                SizedBox(height: 30.h),
                Elevatedbuttonwidget(
                  buttonText: "Explore Collection",
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRouteNames.home,
                      (route) => false,
                    );
                  },
                ),
                SizedBox(height: 18.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Have an account?",
                      style: AppTextStyles.taupeGrey15w400,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRouteNames.login,
                          (route) => false,
                        );
                      },
                      child: Text(
                        " Sign In",
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryMaroon
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
