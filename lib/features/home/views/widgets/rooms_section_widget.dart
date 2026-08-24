import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routing/app_route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/locale_controller.dart';

class RoomsSectionWidget extends StatefulWidget {
  final ValueChanged<String>? onCategorySelected;

  const RoomsSectionWidget({super.key, this.onCategorySelected});
  @override
  State<StatefulWidget> createState() {
    return _RoomsSectionWidget();
  }
}

class _RoomsSectionWidget extends State<RoomsSectionWidget> {
  int _selectedRoomIndex = 0;

  final List<Map<String, String>> _rooms = const [
    {
      'name': 'Living Room',
      'slug': 'furniture',
      'image': 'assets/images/stav_oak_chair.png',
    },
    {
      'name': 'Bedroom',
      'slug': 'furniture',
      'image': 'assets/images/onboarding_img.png',
    },
    {
      'name': 'Chairs',
      'slug': 'furniture',
      'image': 'assets/images/stav_oak_chair.png',
    },
    {
      'name': 'Lighting',
      'slug': 'home-decoration',
      'image': 'assets/images/splash_img.png',
    },
    {
      'name': 'Dining',
      'slug': 'furniture',
      'image': 'assets/images/onboarding_img.png',
    },
    {
      'name': 'Kitchen',
      'slug': 'kitchen-accessories',
      'image': 'assets/images/stav_oak_chair.png',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemCount: _rooms.length,
        itemBuilder: (context, index) {
          final room = _rooms[index];
          final isSelected = index == _selectedRoomIndex;

          return GestureDetector(
            onTap: () {
              setState(() => _selectedRoomIndex = index);
              widget.onCategorySelected?.call(room['slug']!);
            },
            child: Padding(
              padding: EdgeInsets.only(right: 18.w),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(2.r),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primaryMaroon
                            : Colors.transparent,
                        width: 2.r,
                      ),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        room['image']!,
                        width: 60.r,
                        height: 60.r,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset(
                              'assets/images/stav_oak_chair.png',
                              width: 60.r,
                              height: 60.r,
                              fit: BoxFit.cover,
                            ),
                      ),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    localizedCategory(context, room['name']!),
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.w500,
                      color: isSelected
                          ? AppColors.primaryMaroon
                          : AppColors.textGrey,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
