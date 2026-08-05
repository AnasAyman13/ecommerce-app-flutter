import 'package:flutter/material.dart';

import '../../features/auth/views/screens/login_screen.dart';
import '../../features/auth/views/screens/register_screen.dart';
import '../../features/cart/views/screens/cart_screen.dart';
import '../../features/categories/views/screens/categories_screen.dart';
import '../../features/home/views/screens/home_screen.dart';
import '../../features/listing/views/screens/listing_screen.dart';
import '../../features/onboarding/views/screens/onboarding_screen.dart';
import '../../features/orders/views/screens/orders_screen.dart';
import '../../features/profile/views/screens/profile_screen.dart';
import '../../features/product_details/views/screens/product_details_screen.dart';
import '../../features/search/views/screens/search_screen.dart';
import '../../features/settings/views/screens/settings_screen.dart';
import '../../features/splash/views/screens/splash_screen.dart';
import '../../features/wishlist/views/screens/wishlist_screen.dart';
import 'app_route_names.dart';

class AppRouter {
  AppRouter._();

  static const String initialRoute = AppRouteNames.home;

  static Map<String, WidgetBuilder> get routes => {
    AppRouteNames.splash: (_) => const SplashScreen(),
    AppRouteNames.onboarding: (_) => OnboardingScreen(),
    AppRouteNames.login: (_) => const LoginScreen(),
    AppRouteNames.register: (_) => const RegisterScreen(),
    AppRouteNames.home: (_) => const HomeScreen(),
    AppRouteNames.categories: (_) => const CategoriesScreen(),
    AppRouteNames.cart: (_) => const CartScreen(),
    AppRouteNames.orders: (_) => const OrdersScreen(),
    AppRouteNames.search: (_) => const SearchScreen(),
    AppRouteNames.profile: (_) => const ProfileScreen(),
    AppRouteNames.wishlist: (_) => const WishlistScreen(),
    AppRouteNames.settings: (_) => const SettingsScreen(),
  };

  /// For routes that need arguments, use onGenerateRoute
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteNames.listing:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) =>
              ListingScreen(categoryId: args?['categoryId'] as String?),
        );
      case AppRouteNames.productDetails:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) =>
              ProductDetailsScreen(productId: args?['productId'] as String?),
        );
      default:
        return null;
    }
  }
}
