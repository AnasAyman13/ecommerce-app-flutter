
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class Elevatedbuttonwidget extends StatelessWidget{
  final String? buttonText;
  final VoidCallback? onPressed;
  const Elevatedbuttonwidget({super.key, this.buttonText, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primaryMaroon, AppColors.darkBrown],
        ),
        borderRadius: BorderRadius.circular(29.r),
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed ?? () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        iconAlignment: IconAlignment.end,
        icon: Icon(
          Icons.arrow_forward_outlined,
          color: AppColors.white,
        ),
        label: Text(
          buttonText ?? "",
          style: AppTextStyles.buttonText,
        ),
      ),
    );
  }
}