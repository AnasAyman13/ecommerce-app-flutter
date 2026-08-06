import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/routing/app_route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_bottom_nav_bar.dart';
import '../../viewmodels/wishlist_view_model.dart';
import '../widgets/wishlist_item_card.dart';
import '../widgets/wishlist_summary_card.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  late final WishlistViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = WishlistViewModel();
    _viewModel.addListener(_onViewModelChanged);
  }

  @override
  void dispose() {
    _viewModel.removeListener(_onViewModelChanged);
    _viewModel.dispose();
    super.dispose();
  }

  void _onViewModelChanged() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgCream,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'My Wishlist',
                          style: AppTextStyles.serifHeader.copyWith(
                            fontSize: 26.sp,
                            color: AppColors.textDark,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          '${_viewModel.itemCount} pieces saved',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: AppColors.textGrey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.lightPillBg,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.ios_share_rounded,
                            size: 16.sp,
                            color: AppColors.textDark,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            'Share',
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: WishlistSummaryCard(
                  totalValue: _viewModel.totalSavedValue,
                  onAddAllToCart: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Added all wishlist items to cart!'),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _viewModel.items.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.72,
                    crossAxisSpacing: 14.w,
                    mainAxisSpacing: 16.h,
                  ),
                  itemBuilder: (context, index) {
                    final item = _viewModel.items[index];
                    return WishlistItemCard(
                      item: item,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRouteNames.productDetails,
                          arguments: {'productId': item.id},
                        );
                      },
                      onRemove: () => _viewModel.removeItem(index),
                    );
                  },
                ),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 3),
    );
  }
}
