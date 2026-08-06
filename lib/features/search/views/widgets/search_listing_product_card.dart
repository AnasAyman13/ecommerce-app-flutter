import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class SearchListingProductCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback onTap;

  const SearchListingProductCard({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24.r),
                    ),
                    child: Image.network(
                      item['imageUrl'] as String,
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Image.asset(
                        'assets/images/stav_oak_chair.png',
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  if (item['isSale'] == true)
                    Positioned(
                      top: 10.h,
                      left: 10.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryMaroon,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          'SALE',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    top: 10.h,
                    right: 10.w,
                    child: Container(
                      padding: EdgeInsets.all(6.r),
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.favorite_border_rounded,
                        size: 16.sp,
                        color: AppColors.primaryMaroon,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ...List.generate(
                        5,
                        (i) => Icon(
                          Icons.star_rounded,
                          size: 12.sp,
                          color: AppColors.starYellow,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '${item['rating']}',
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: AppColors.textGrey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    item['title'] as String,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Text(
                        item['price'] as String,
                        style: AppTextStyles.serifPrice.copyWith(
                          fontSize: 15.sp,
                        ),
                      ),
                      if (item['oldPrice'] != null) ...[
                        SizedBox(width: 6.w),
                        Text(
                          item['oldPrice'] as String,
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: AppColors.textGrey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
