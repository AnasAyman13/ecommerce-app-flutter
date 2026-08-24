import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';

class ProfileQuickActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const ProfileQuickActionCard({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: AppColors.lightPillBg,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.primaryMaroon, size: 20.sp),
            ),
            SizedBox(height: 8.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
