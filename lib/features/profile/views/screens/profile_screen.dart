import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/routing/app_route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_bottom_nav_bar.dart';
import '../../viewmodels/profile_view_model.dart';
import '../widgets/profile_header_card.dart';
import '../widgets/profile_option_tile.dart';
import '../widgets/profile_quick_action_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final ProfileViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ProfileViewModel();
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
            children: [
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: ProfileHeaderCard(user: _viewModel.user),
              ),
              SizedBox(height: 18.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    Expanded(
                      child: ProfileQuickActionCard(
                        icon: Icons.edit_outlined,
                        label: 'Edit profile',
                        onTap: () {},
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: ProfileQuickActionCard(
                        icon: Icons.chat_bubble_outline_rounded,
                        label: 'Support',
                        onTap: () {},
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: ProfileQuickActionCard(
                        icon: Icons.shield_outlined,
                        label: 'Privacy',
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 18.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    ProfileOptionTile(
                      icon: Icons.receipt_long_outlined,
                      title: 'My Orders',
                      badge: '${_viewModel.user.ordersCount}',
                      onTap: () {
                        Navigator.pushNamed(context, AppRouteNames.orders);
                      },
                    ),
                    SizedBox(height: 10.h),
                    ProfileOptionTile(
                      icon: Icons.favorite_border_rounded,
                      title: 'Wishlist',
                      badge: '${_viewModel.user.savedCount}',
                      onTap: () {
                        Navigator.pushNamed(context, AppRouteNames.wishlist);
                      },
                    ),
                    SizedBox(height: 10.h),
                    ProfileOptionTile(
                      icon: Icons.location_on_outlined,
                      title: 'Delivery Addresses',
                      onTap: () {
                        Navigator.pushNamed(context, AppRouteNames.settings);
                      },
                    ),
                    SizedBox(height: 10.h),
                    ProfileOptionTile(
                      icon: Icons.help_outline_rounded,
                      title: 'Help & Support',
                      onTap: () {
                        Navigator.pushNamed(context, AppRouteNames.settings);
                      },
                    ),
                    SizedBox(height: 10.h),
                    ProfileOptionTile(
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
}
