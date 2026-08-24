import 'package:ecommerce_app/core/models/favorite_item_model.dart';
import 'package:ecommerce_app/features/home/viewmodels/home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/locale_controller.dart';

class SingleFeatureCardWidget extends StatefulWidget {
  final int id;
  final String name;
  final double price;
  final String imgUrl;
  final double rating;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback? onFavoriteTap;
  SingleFeatureCardWidget(
    this.id,
    this.name,
    this.price,
    this.imgUrl,
    this.rating,
    this.isFavorite,
    this.onTap,
    this.onFavoriteTap, {
    super.key,
  });
  @override
  State<StatefulWidget> createState() => _SingleFeatureCardWidget();
}

class _SingleFeatureCardWidget extends State<SingleFeatureCardWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: double.infinity,
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
                      widget.imgUrl,
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
                  // if (item['isSale'] == true)
                  //   Positioned(
                  //     top: 10.h,
                  //     left: 10.w,
                  //     child: Container(
                  //       padding: EdgeInsets.symmetric(
                  //         horizontal: 10.w,
                  //         vertical: 4.h,
                  //       ),
                  //       decoration: BoxDecoration(
                  //         color: AppColors.primaryMaroon,
                  //         borderRadius: BorderRadius.circular(
                  //           8.r,
                  //         ),
                  //       ),
                  //       child: Text(
                  //         'SALE',
                  //         style: TextStyle(
                  //           color: AppColors.white,
                  //           fontSize: 10.sp,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  Positioned(
                    top: 10.h,
                    right: 10.w,
                    child: Container(
                      // padding: EdgeInsets.all(1.r),
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                        shape: BoxShape.circle,
                      ),
                      child: ValueListenableBuilder<Box>(
                        valueListenable: Hive.box<FavoriteItemModel>(
                          "favorites_box",
                        ).listenable(),
                        builder: (context, box, child) {
                          final isFavorite = box.containsKey(widget.id);
                          return IconButton(
                            color: AppColors.primaryMaroon,
                            onPressed: widget.onFavoriteTap,
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                            ),
                          );
                        },
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
                        widget.rating.toString(),
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: AppColors.textGrey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    widget.name,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'EGP ${widget.price.toStringAsFixed(0)}',
                    style: AppTextStyles.serifPrice.copyWith(fontSize: 15.sp),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    tr(context, 'In stock', 'متوفر بالمخزن'),
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: AppColors.mintGreen,
                      fontWeight: FontWeight.w700,
                    ),
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
