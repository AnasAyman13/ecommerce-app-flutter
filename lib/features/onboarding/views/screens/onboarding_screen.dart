import 'package:ecommerce_app/core/routing/app_route_names.dart';
import 'package:ecommerce_app/core/theme/app_colors.dart';
import 'package:ecommerce_app/core/theme/app_text_styles.dart';
import 'package:ecommerce_app/core/utils/view_state.dart';
import 'package:ecommerce_app/features/onboarding/viewmodels/onboarding_view_model.dart';
import 'package:ecommerce_app/features/onboarding/views/widgets/elevatedButtonWidget.dart';
import 'package:ecommerce_app/features/onboarding/views/widgets/onboardingTopSectionWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  String _targetRoute = AppRouteNames.home;

  void _onNavigateTriggered(BuildContext context, String route) {
    _targetRoute = route;
    context.read<OnboardingViewModel>().completeOnboarding();
    Navigator.pushReplacementNamed(context, _targetRoute);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardingViewModel, ViewState<void>>(
      listener: (context, state) {
        if (state.status == ViewStatus.success) {

        } else if (state.status == ViewStatus.failure) {
          
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  const Onboardingtopsectionwidget(
                    imagePath: 'assets/images/onboarding_img.png',
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.r),
                    child: SafeArea(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "NORR",
                            style: TextStyle(
                              fontFamily: "Fraunces",
                              color: Colors.white,
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          OutlinedButton(
                            onPressed: () {
                              _onNavigateTriggered(context, AppRouteNames.home);
                            },
                            style: OutlinedButton.styleFrom(
                              backgroundColor: const Color(
                                0xFFFFFFFF,
                              ).withOpacity(0.1),
                              side: BorderSide.none,
                            ),
                            child: Text(
                              "Skip",
                              style: TextStyle(
                                fontFamily: "Fraunces",
                                color: Colors.white,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20.h,
                    left: 20.w,
                    right: 20.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "OSLO COLLECTION",
                              style: AppTextStyles.goldAccent11w600,
                            ),
                            Text(
                              "360°",
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: Container(
                                height: 3.h,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryMaroon,
                                  borderRadius: BorderRadius.circular(2.r),
                                ),
                              ),
                            ),
                            SizedBox(width: 6.w),
                            Expanded(
                              flex: 2,
                              child: Container(
                                height: 3.h,
                                decoration: BoxDecoration(
                                  color: const Color(0xffE8E0D5),
                                  borderRadius: BorderRadius.circular(2.r),
                                ),
                              ),
                            ),
                            SizedBox(width: 6.w),
                            Expanded(
                              flex: 2,
                              child: Container(
                                height: 3.h,
                                decoration: BoxDecoration(
                                  color: const Color(0xffE8E0D5),
                                  borderRadius: BorderRadius.circular(2.r),
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
              Padding(
                padding: EdgeInsets.all(20.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Designed for",
                      style: AppTextStyles.onboardingHeadingtxt,
                    ),
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
                        _onNavigateTriggered(context, AppRouteNames.home);
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
                            _onNavigateTriggered(context, AppRouteNames.login);
                          },
                          child: Text(
                            " Sign In",
                            style: TextStyle(
                              fontFamily: "Fraunces",
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryMaroon,
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
        ),
      ),
    );
  }
}
