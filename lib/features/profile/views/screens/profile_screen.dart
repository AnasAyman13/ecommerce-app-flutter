import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/routing/app_route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_bottom_nav_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgCream,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 12.h),

              // 1. Profile Header Banner Card
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Container(
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
                      // User Info Row
                      Row(
                        children: [
                          // Avatar
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
                                'E',
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
                                  'Elina Bergström',
                                  style: AppTextStyles.serifHeader.copyWith(
                                    color: AppColors.white,
                                    fontSize: 20.sp,
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  'elina@norr.co · Member since 2022',
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
                                    '+ GOLD MEMBER',
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

                      // Stats Row (Orders, Reviews, Saved, Spent)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatItem('12', 'Orders'),
                          _buildStatDivider(),
                          _buildStatItem('4', 'Reviews'),
                          _buildStatDivider(),
                          _buildStatItem('28', 'Saved'),
                          _buildStatDivider(),
                          _buildStatItem('\$8.2k', 'Spent'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 18.h),

              // 2. Quick Action Grid (Edit profile, Support, Privacy)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildQuickActionCard(
                        icon: Icons.edit_outlined,
                        label: 'Edit profile',
                        onTap: () {},
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _buildQuickActionCard(
                        icon: Icons.chat_bubble_outline_rounded,
                        label: 'Support',
                        onTap: () {},
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _buildQuickActionCard(
                        icon: Icons.shield_outlined,
                        label: 'Privacy',
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 18.h),

              // 3. Options List (My Orders, Wishlist, Addresses, Help, Privacy)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    // My Orders
                    _buildOptionTile(
                      context,
                      icon: Icons.receipt_long_outlined,
                      title: 'My Orders',
                      badge: '3',
                      onTap: () {
                        Navigator.pushNamed(context, AppRouteNames.orders);
                      },
                    ),
                    SizedBox(height: 10.h),

                    // Wishlist
                    _buildOptionTile(
                      context,
                      icon: Icons.favorite_border_rounded,
                      title: 'Wishlist',
                      badge: '6',
                      onTap: () {
                        Navigator.pushNamed(context, AppRouteNames.wishlist);
                      },
                    ),
                    SizedBox(height: 10.h),

                    // Delivery Addresses
                    _buildOptionTile(
                      context,
                      icon: Icons.location_on_outlined,
                      title: 'Delivery Addresses',
                      onTap: () {
                        Navigator.pushNamed(context, AppRouteNames.settings);
                      },
                    ),
                    SizedBox(height: 10.h),

                    // Help & Support
                    _buildOptionTile(
                      context,
                      icon: Icons.help_outline_rounded,
                      title: 'Help & Support',
                      onTap: () {
                        Navigator.pushNamed(context, AppRouteNames.settings);
                      },
                    ),
                    SizedBox(height: 10.h),

                    // Privacy & Security
                    _buildOptionTile(
                      context,
                      icon: Icons.lock_outline_rounded,
                      title: 'Privacy & Security',
                      onTap: () {
                        Navigator.pushNamed(context, AppRouteNames.settings);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 4),
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

  Widget _buildQuickActionCard({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
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
              decoration: const BoxDecoration(
                color: AppColors.lightPillBg,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: AppColors.primaryMaroon,
                size: 20.sp,
              ),
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

  Widget _buildOptionTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? badge,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
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
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.r),
              decoration: const BoxDecoration(
                color: AppColors.lightPillBg,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: AppColors.primaryMaroon,
                size: 18.sp,
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
            ),
            if (badge != null) ...[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.primaryMaroon,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  badge,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
            ],
            Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textGrey,
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }
}
