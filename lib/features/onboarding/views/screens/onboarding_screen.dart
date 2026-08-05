import 'dart:ffi';

import 'package:ecommerce_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';

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
              ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(52.r),
                    bottomRight: Radius.circular(52.r)
                ),
                child: SizedBox(
                  height: screenHeight * 0.55,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Image.asset(

                        'assets/images/onboarding_img.png',
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Container(

                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(

                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              const Color(0xFF39201E).withValues(alpha: 0.05), // rgba(57, 32, 30, 0.05)
                              Colors.transparent,                              // rgba(0, 0, 0, 0)
                              const Color(0xFFFAF7F2).withValues(alpha: 0.9),  // rgba(250, 247, 242, 0.9)
                              const Color(0xFFFAF7F2),                         // rgb(250, 247, 242)
                            ],
                            stops: const [0.0, 0.40, 0.85, 1.0],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),


              //  SizedBox(width: 20),
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
                        onPressed: () {},
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
                  //right: 20.w,
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
              //mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Designed for", style: AppTextStyles.onboardingHeadingtxt),
                Text(
                  "living beautifally",
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
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColors.primaryMaroon, AppColors.darkBrown],
                    ),
                    borderRadius: BorderRadius.circular(29.r),
                  ),
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    iconAlignment: IconAlignment.end,
                    icon: Icon(
                      Icons.arrow_forward_outlined,
                      color: AppColors.white,
                    ),
                    label: Text(
                      "Explore Collection",
                      style: AppTextStyles.buttonText,
                    ),
                  ),
                ),
                SizedBox(height: 18.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Have an account?",
                      style: AppTextStyles.taupeGrey15w400,
                    ),
                    Text(
                      " Sign In",
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryMaroon
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
