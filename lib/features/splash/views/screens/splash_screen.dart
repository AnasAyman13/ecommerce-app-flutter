import 'package:ecommerce_app/features/onboarding/views/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>  OnboardingScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2C1917),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Image.asset(
            'assets/images/splash_img.png',
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),

          Container(
            width: double.infinity,
            height: double.infinity,
            color: const Color(0xFF2C1E1C).withOpacity(0.82),
          ),

          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: Column(
                children: [
                  const Spacer(),

                  Container(
                    width: 72.r,
                    height: 72.r,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(22.r),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.15),
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.chair_outlined,
                        color: const Color(0xFFC69C6D),
                        size: 32.r,
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  Text(
                    "NORR",
                    style: TextStyle(
                      fontFamily: "Fraunces",
                      fontSize: 42.sp,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3.0,
                      color: Colors.white,
                    ),
                  ),

                  SizedBox(height: 6.h),

                  Text(
                    "LUXURY FURNITURE",
                    style: TextStyle(
                      fontFamily: "Fraunces",
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2.8,
                      color: const Color(0xFFC69C6D),
                    ),
                  ),

                  const Spacer(),

                  Container(
                    width: 32.r,
                    height: 32.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Container(
                        width: 6.r,
                        height: 6.r,
                        decoration: const BoxDecoration(
                          color: Color(0xFFC69C6D),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 16.h),

                  Text(
                    "CRAFTED WITH INTENTION",
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2.0,
                      color: Colors.white.withOpacity(0.45),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}