import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../routing/app_route_names.dart';
import '../theme/app_colors.dart';
import '../theme/locale_controller.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavBar({super.key, required this.currentIndex});

  void _onItemTapped(BuildContext context, int index) {
    if (index == currentIndex) return;

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, AppRouteNames.home);
        break;
      case 1:
        Navigator.pushReplacementNamed(context, AppRouteNames.search);
        break;
      case 2:
        Navigator.pushReplacementNamed(context, AppRouteNames.cart);
        break;
      case 3:
        Navigator.pushReplacementNamed(context, AppRouteNames.wishlist);
        break;
      case 4:
        Navigator.pushReplacementNamed(context, AppRouteNames.profile);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      _NavItem(
        icon: Icons.home_outlined,
        activeIcon: Icons.home_rounded,
        label: tr(context, 'Home', 'الرئيسية'),
      ),
      _NavItem(
        icon: Icons.search_rounded,
        activeIcon: Icons.search_rounded,
        label: tr(context, 'Explore', 'استكشاف'),
      ),
      _NavItem(
        icon: Icons.shopping_bag_outlined,
        activeIcon: Icons.shopping_bag,
        label: tr(context, 'Cart', 'السلة'),
      ),
      _NavItem(
        icon: Icons.favorite_border_rounded,
        activeIcon: Icons.favorite_rounded,
        label: tr(context, 'Saved', 'المفضلة'),
      ),
      _NavItem(
        icon: Icons.person_outline_rounded,
        activeIcon: Icons.person_rounded,
        label: tr(context, 'Profile', 'حسابي'),
      ),
    ];

    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(26.r)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.bgCream.withValues(alpha: .72),
            border: Border(
              top: BorderSide(
                color: AppColors.white.withValues(alpha: .65),
                width: 1.r,
              ),
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 6.h),
          child: SafeArea(
            top: false,
            child: Row(
              children: List.generate(items.length, (index) {
                final item = items[index];
                final isActive = index == currentIndex;

                return Expanded(
                  child: InkWell(
                    onTap: () => _onItemTapped(context, index),
                    borderRadius: BorderRadius.circular(20.r),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 14.w,
                                  vertical: 5.h,
                                ),
                                decoration: BoxDecoration(
                                  color: isActive
                                      ? AppColors.lightPillBg
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Icon(
                                  isActive ? item.activeIcon : item.icon,
                                  color: isActive
                                      ? AppColors.primaryMaroon
                                      : AppColors.textGrey,
                                  size: 20.sp,
                                ),
                              ),
                              if (item.badge != null)
                                Positioned(
                                  top: -2.h,
                                  right: 4.w,
                                  child: Container(
                                    padding: EdgeInsets.all(4.r),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryMaroon,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(
                                      item.badge!,
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 9.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            item.label,
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: isActive
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              color: isActive
                                  ? AppColors.primaryMaroon
                                  : AppColors.textGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final String? badge;

  _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    this.badge,
  });
}
