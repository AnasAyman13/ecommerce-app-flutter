import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Onboardingtopsectionwidget extends StatelessWidget {
  final String? imagePath;
  const Onboardingtopsectionwidget({super.key, this.imagePath});
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(52.r),
        bottomRight: Radius.circular(52.r),
      ),
      child: SizedBox(
        height: screenHeight * 0.55,
        width: double.infinity,
        child: Stack(
          children: [
            Image.asset(
              imagePath ?? "",
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
                    const Color(
                      0xFF39201E,
                    ).withValues(alpha: 0.05), // rgba(57, 32, 30, 0.05)
                    Colors.transparent, // rgba(0, 0, 0, 0)
                    const Color(
                      0xFFFAF7F2,
                    ).withValues(alpha: 0.9), // rgba(250, 247, 242, 0.9)
                    const Color(0xFFFAF7F2), // rgb(250, 247, 242)
                  ],
                  stops: const [0.0, 0.40, 0.85, 1.0],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
