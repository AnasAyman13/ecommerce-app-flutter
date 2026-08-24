import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/locale_controller.dart';

class HomeHeroSectionWidget extends StatelessWidget {
  const HomeHeroSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final name = sl<SharedPreferences>().getString('session_user') ?? 'Guest';
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  tr(context, 'Good morning ', 'صباح الخير '),
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: AppColors.textGrey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(Icons.star, size: 10.sp, color: AppColors.textGrey),
              ],
            ),
            SizedBox(height: 2.h),
            Text(
              name,
              style: AppTextStyles.serifHeader.copyWith(
                fontSize: 28.sp,
                height: 1.1,
              ),
            ),
          ],
        ),
        Row(
          children: [
            // Bell Button
            InkWell(
              onTap: () => _showNotifications(context),
              borderRadius: BorderRadius.circular(30.r),
              child: Container(
                width: 44.r,
                height: 44.r,
                decoration: BoxDecoration(
                  color: AppColors.lightPillBg,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.notifications_none_rounded,
                  color: AppColors.textDark,
                  size: 22.sp,
                ),
              ),
            ),
            SizedBox(width: 10.w),
            // Profile Avatar
            Container(
              width: 44.r,
              height: 44.r,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFB8564D), Color(0xFF832C31)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  name.isNotEmpty ? name[0].toUpperCase() : 'U',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'serif',
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showNotifications(BuildContext context) {
    final prefs = sl<SharedPreferences>();
    final last = prefs.getString('last_notification');
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF2A2422)
          : Colors.white,
      builder: (context) => SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tr(context, 'Notifications', 'الإشعارات'),
                style: AppTextStyles.serifHeader.copyWith(fontSize: 24.sp),
              ),
              SizedBox(height: 12.h),
              ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.local_shipping_outlined),
                ),
                title: Text(
                  last ?? tr(context, 'Order updates', 'تحديثات الطلب'),
                ),
                subtitle: Text(
                  last == null
                      ? tr(
                          context,
                          'Your latest order is being prepared.',
                          'يتم تجهيز طلبك الأخير.',
                        )
                      : tr(
                          context,
                          'Mock notification from your latest action.',
                          'إشعار تجريبي بآخر إجراء قمت به.',
                        ),
                ),
              ),
              ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.local_offer_outlined),
                ),
                title: Text(tr(context, 'Fresh arrivals', 'وصل حديثًا')),
                subtitle: Text(
                  tr(
                    context,
                    'New furniture pieces are available now.',
                    'قطع أثاث جديدة متاحة الآن.',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
