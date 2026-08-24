import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/database/fav_repository/favorites_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/routing/app_route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/locale_controller.dart';
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
    _viewModel = ProfileViewModel(
      sl<SharedPreferences>(),
      sl<FavoritesRepository>(),
    );
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
                        label: tr(context, 'Edit profile', 'تعديل الحساب'),
                        onTap: () => Navigator.pushNamed(
                          context,
                          AppRouteNames.settings,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: ProfileQuickActionCard(
                        icon: Icons.chat_bubble_outline_rounded,
                        label: tr(context, 'Support', 'الدعم'),
                        onTap: () => _showInfo(
                          context,
                          tr(context, 'Support', 'الدعم'),
                          tr(
                            context,
                            'We are here to help. Contact support@norr.co.',
                            'نحن هنا لمساعدتك. تواصل مع support@norr.co.',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: ProfileQuickActionCard(
                        icon: Icons.shield_outlined,
                        label: tr(context, 'Privacy', 'الخصوصية'),
                        onTap: () => _showInfo(
                          context,
                          tr(context, 'Privacy', 'الخصوصية'),
                          tr(
                            context,
                            'Your local profile and cart data stay on this device.',
                            'بيانات حسابك وسلة التسوق محفوظة محليًا على جهازك.',
                          ),
                        ),
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
                      title: tr(context, 'My Orders', 'طلباتي'),
                      badge: '${_viewModel.user.ordersCount}',
                      onTap: () {
                        Navigator.pushNamed(context, AppRouteNames.orders);
                      },
                    ),
                    SizedBox(height: 10.h),
                    ProfileOptionTile(
                      icon: Icons.favorite_border_rounded,
                      title: tr(context, 'Wishlist', 'المفضلة'),
                      badge: '${_viewModel.user.savedCount}',
                      onTap: () {
                        Navigator.pushNamed(context, AppRouteNames.wishlist);
                      },
                    ),
                    SizedBox(height: 10.h),
                    ProfileOptionTile(
                      icon: Icons.location_on_outlined,
                      title: tr(
                        context,
                        'Delivery Addresses',
                        'عناوين التوصيل',
                      ),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRouteNames.settings,
                          arguments: {'openAddress': true},
                        );
                      },
                    ),
                    SizedBox(height: 10.h),
                    ProfileOptionTile(
                      icon: Icons.help_outline_rounded,
                      title: tr(context, 'Help & Support', 'المساعدة والدعم'),
                      onTap: () {
                        Navigator.pushNamed(context, AppRouteNames.settings);
                      },
                    ),
                    SizedBox(height: 10.h),
                    ProfileOptionTile(
                      icon: Icons.lock_outline_rounded,
                      title: tr(
                        context,
                        'Privacy & Security',
                        'الخصوصية والأمان',
                      ),
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

void _showInfo(BuildContext context, String title, String message) {
  showDialog<void>(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(title),
      content: SelectableText(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
