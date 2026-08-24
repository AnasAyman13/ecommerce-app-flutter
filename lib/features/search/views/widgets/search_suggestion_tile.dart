import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';

class SearchSuggestionTile extends StatelessWidget {
  final String prefix;
  final String suffix;
  final VoidCallback onTap;

  const SearchSuggestionTile({
    super.key,
    required this.prefix,
    required this.suffix,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          children: [
            Icon(Icons.search_rounded, size: 16.sp, color: AppColors.textGrey),
            SizedBox(width: 12.w),
            RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 13.sp, color: AppColors.textDark),
                children: [
                  TextSpan(
                    text: prefix,
                    style: TextStyle(
                      color: AppColors.primaryMaroon,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(text: suffix),
                ],
              ),
            ),
            const Spacer(),
            Icon(
              Icons.north_west_rounded,
              size: 14.sp,
              color: AppColors.textGrey,
            ),
          ],
        ),
      ),
    );
  }
}
