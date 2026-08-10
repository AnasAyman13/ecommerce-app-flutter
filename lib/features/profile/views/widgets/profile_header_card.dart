import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../models/profile_user_model.dart';

class ProfileHeaderCard extends StatelessWidget {
  final ProfileUserModel user;

  const ProfileHeaderCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: const Color(0xFF6E282D),
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6E282D).withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 58.r,
                height: 58.r,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFE5A638), Color(0xFFC0821B)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    user.name.isNotEmpty ? user.name[0] : 'U',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'serif',
                    ),
                  ),
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: AppTextStyles.serifHeader.copyWith(
                        color: AppColors.white,
                        fontSize: 20.sp,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      '${user.email} · Member since ${user.memberSince}',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.75),
                        fontSize: 11.sp,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 3.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFB8860B),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        user.badge,
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Divider(color: Colors.white.withValues(alpha: 0.15)),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem('${user.ordersCount}', 'Orders'),
              _buildStatDivider(),
              _buildStatItem('${user.reviewsCount}', 'Reviews'),
              _buildStatDivider(),
              _buildStatItem('${user.savedCount}', 'Saved'),
              _buildStatDivider(),
              _buildStatItem(user.spentAmount, 'Spent'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyles.serifHeader.copyWith(
            color: AppColors.white,
            fontSize: 18.sp,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 11.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildStatDivider() {
    return Container(
      height: 24.h,
      width: 1.w,
      color: Colors.white.withValues(alpha: 0.2),
    );
  }
}
