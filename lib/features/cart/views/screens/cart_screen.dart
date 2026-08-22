
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_bottom_nav_bar.dart';
import '../../models/cart_item_model.dart';
import '../../view_models/cart_view_model.dart';
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _CartViewContent();
  }
}

class _CartViewContent extends StatelessWidget {
  const _CartViewContent();

  String _formatCurrency(double amount) {
    return '\$${amount.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
  }

  @override
  Widget build(BuildContext context) {
    final cartViewModel = context.watch<CartViewModel>();

    final cartItems = cartViewModel.cartItems;
    final totalItemCount = cartViewModel.totalItemCount;
    final subtotal = cartViewModel.subtotal;
    final promoDiscount = cartViewModel.promoDiscount;
    final estimatedTax = cartViewModel.estimatedTax;
    final grandTotal = cartViewModel.grandTotal;

    return Scaffold(
      backgroundColor: AppColors.bgCream,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 8.h),

            // Header Row
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.maybePop(context),
                    child: Container(
                      width: 42.r,
                      height: 42.r,
                      decoration: const BoxDecoration(
                        color: AppColors.lightPillBg,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        color: AppColors.textDark,
                        size: 20.sp,
                      ),
                    ),
                  ),

                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Shopping Cart',
                          style: AppTextStyles.serifHeader.copyWith(
                            fontSize: 22.sp,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 3.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryMaroon,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            '$totalItemCount',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: 42.r),
                ],
              ),
            ),

            SizedBox(height: 14.h),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    // Free Shipping Banner
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.mintBg,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: AppColors.mintGreen.withOpacity(0.3),
                          width: 1.r,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.local_shipping_outlined,
                            color: AppColors.mintGreen,
                            size: 22.sp,
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Text(
                              'You qualify for FREE white-glove delivery! 🎉',
                              style: TextStyle(
                                color: AppColors.mintGreen,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 14.h),

                    // Cart Items List
                    ...cartItems.map(
                      (item) => Padding(
                        padding: EdgeInsets.only(bottom: 14.h),
                        child: _buildCartItemTile(context, item),
                      ),
                    ),

                    // Promo Code Row
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 48.h,
                            padding: EdgeInsets.symmetric(horizontal: 14.w),
                            decoration: BoxDecoration(
                              color: AppColors.lightPillBg,
                              borderRadius: BorderRadius.circular(18.r),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.local_offer_outlined,
                                  color: AppColors.textGrey,
                                  size: 18.sp,
                                ),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: TextField(
                                    controller: TextEditingController(
                                      text: 'NORR15',
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Promo code',
                                      hintStyle: TextStyle(
                                        color: AppColors.textGrey,
                                        fontSize: 13.sp,
                                      ),
                                      border: InputBorder.none,
                                      isDense: true,
                                    ),
                                    style: TextStyle(
                                      color: AppColors.textDark,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(width: 10.w),

                        GestureDetector(
                          onTap: () {
                            final success = cartViewModel.applyPromoCode(
                              'NORR15',
                            );

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  success
                                      ? 'Promo code applied successfully!'
                                      : 'Invalid promo code',
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: 48.h,
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            decoration: BoxDecoration(
                              color: AppColors.darkBrownPill,
                              borderRadius: BorderRadius.circular(18.r),
                            ),
                            child: Center(
                              child: Text(
                                'Apply',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16.h),

                    // Order Summary Card
                    Container(
                      padding: EdgeInsets.all(20.r),
                      decoration: BoxDecoration(
                        color: AppColors.cardBg,
                        borderRadius: BorderRadius.circular(24.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order Summary',
                            style: AppTextStyles.serifTitle.copyWith(
                              fontSize: 18.sp,
                            ),
                          ),

                          SizedBox(height: 14.h),

                          // Subtotal
                          _buildSummaryRow(
                            'Subtotal ($totalItemCount items)',
                            _formatCurrency(subtotal),
                          ),

                          SizedBox(height: 10.h),

                          // Delivery
                          _buildSummaryRow(
                            'White-glove Delivery',
                            'Free',
                            valueStyle: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark,
                            ),
                          ),

                          SizedBox(height: 10.h),

                          // Promo
                          _buildSummaryRow(
                            'Promo — NORR15',
                            '-${_formatCurrency(promoDiscount)}',
                            valueStyle: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.mintGreen,
                            ),
                          ),

                          SizedBox(height: 10.h),

                          // Estimated Tax
                          _buildSummaryRow(
                            'Estimated Tax',
                            _formatCurrency(estimatedTax),
                          ),

                          SizedBox(height: 14.h),

                          Divider(color: AppColors.lightBorder, height: 1.h),

                          SizedBox(height: 14.h),

                          // Total
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textDark,
                                ),
                              ),
                              Text(
                                _formatCurrency(grandTotal),
                                style: AppTextStyles.serifPriceLarge.copyWith(
                                  fontSize: 24.sp,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 18.h),

                          // Checkout Button
                          GestureDetector(
                            onTap: () {
                              if (cartViewModel.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Your cart is empty.'),
                                  ),
                                );
                                return;
                              }

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Proceeding to Checkout...'),
                                ),
                              );
                            },
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              decoration: BoxDecoration(
                                color: AppColors.darkBrownPill,
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.credit_card_rounded,
                                    color: AppColors.white,
                                    size: 20.sp,
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    'Proceed to Checkout',
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),
    );
  }

  Widget _buildSummaryRow(String title, String value, {TextStyle? valueStyle}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 13.sp, color: AppColors.textGrey),
        ),
        Text(
          value,
          style:
              valueStyle ??
              TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
        ),
      ],
    );
  }

  Widget _buildCartItemTile(BuildContext context, CartItemModel item) {
    final cartViewModel = context.read<CartViewModel>();

    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Item Image
          ClipRRect(
            borderRadius: BorderRadius.circular(18.r),
            child: Image.network(
              item.imageUrl,
              width: 90.r,
              height: 90.r,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 90.r,
                  height: 90.r,
                  color: AppColors.lightPillBg,
                  child: const Icon(Icons.chair, color: AppColors.textGrey),
                );
              },
            ),
          ),

          SizedBox(width: 12.w),

          // Details & Controls
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        item.title,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    // Delete Button
                    GestureDetector(
                      onTap: () {
                        cartViewModel.removeItem(item.id);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${item.title} removed from cart'),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(4.r),
                        decoration: const BoxDecoration(
                          color: AppColors.cancelledBg,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.close,
                          size: 14.sp,
                          color: AppColors.cancelledRed,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 2.h),

                Text(
                  item.variant,
                  style: TextStyle(fontSize: 12.sp, color: AppColors.textGrey),
                ),

                SizedBox(height: 12.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.formattedPrice,
                      style: AppTextStyles.serifPrice.copyWith(fontSize: 18.sp),
                    ),

                    // Quantity Control
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.lightPillBg,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        children: [
                          // Decrease
                          InkWell(
                            onTap: () {
                              cartViewModel.decreaseQuantity(item.id);
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 4.h,
                              ),
                              child: Text(
                                '—',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textDark,
                                ),
                              ),
                            ),
                          ),

                          // Quantity
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6.w),
                            child: Text(
                              '${item.quantity}',
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textDark,
                              ),
                            ),
                          ),

                          // Increase
                          InkWell(
                            onTap: () {
                              cartViewModel.increaseQuantity(item.id);
                            },
                            child: Container(
                              padding: EdgeInsets.all(6.r),
                              decoration: const BoxDecoration(
                                color: AppColors.primaryMaroon,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.add,
                                size: 12.sp,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
