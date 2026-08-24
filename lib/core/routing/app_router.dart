import 'package:ecommerce_app/core/api/api_client.dart';
import 'package:ecommerce_app/features/onboarding/viewmodels/onboarding_view_model.dart';
import 'package:ecommerce_app/features/splash/viewmodels/splash_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/views/screens/login_screen.dart';
import '../../features/auth/views/screens/register_screen.dart';
import '../../features/cart/views/screens/cart_screen.dart';
import '../../features/checkout/views/screens/checkout_screen.dart';
import '../../features/categories/views/screens/categories_screen.dart';
import '../../features/categories/repositories/categories_repository.dart';
import '../../features/categories/viewmodels/categories_view_model.dart';
import '../../features/home/repositories/home_repository.dart';
import '../../features/home/viewmodels/home_view_model.dart';
import '../../features/home/views/screens/home_screen.dart';
import '../../features/listing/views/screens/listing_screen.dart';
import '../../features/onboarding/views/screens/onboarding_screen.dart';
import '../../features/orders/views/screens/orders_screen.dart';
import '../../features/profile/views/screens/profile_screen.dart';
import '../../features/product_details/views/screens/product_details_screen.dart';
import '../../features/product_details/repositories/product_details_repository.dart';
import '../../features/product_details/viewmodels/product_details_view_model.dart';
import '../../features/search/views/screens/search_screen.dart';
import '../../features/search/repositories/search_repository.dart';
import '../../features/search/viewmodels/search_view_model.dart';
import '../../features/settings/views/screens/settings_screen.dart';
import '../../features/splash/views/screens/splash_screen.dart';
import '../../features/wishlist/views/screens/wishlist_screen.dart';
import '../di/service_locator.dart';
import 'app_route_names.dart';

class AppRouter {
  AppRouter._();

  static const String initialRoute = AppRouteNames.splash;

  static Map<String, WidgetBuilder> get routes => {
    //AppRouteNames.splash: (_) => const SplashScreen(),
    AppRouteNames.splash: (context) => BlocProvider(
      create: (context) => sl<SplashViewModel>()..initialize(),
      child: const SplashScreen(),
    ),
    //AppRouteNames.onboarding: (_) => OnboardingScreen(),
    AppRouteNames.onboarding: (context) => BlocProvider(
      create: (context) => sl<OnboardingViewModel>()..completeOnboarding(),
      child: const OnboardingScreen(),
    ),
    AppRouteNames.login: (_) => const LoginScreen(),
    AppRouteNames.register: (_) => const RegisterScreen(),
    AppRouteNames.home: (context) => BlocProvider(
      create: (context) => sl<HomeViewModel>()..loadHome(),
      child: const HomeScreen(),
    ),
    AppRouteNames.categories: (_) => BlocProvider(
      create: (_) =>
          CategoriesViewModel(sl<CategoriesRepository>())..loadCategories(),
      child: const CategoriesScreen(),
    ),
    AppRouteNames.cart: (_) => const CartScreen(),
    AppRouteNames.checkout: (_) => const CheckoutScreen(),
    AppRouteNames.orders: (_) => const OrdersScreen(),
    AppRouteNames.search: (_) => BlocProvider(
      create: (_) => SearchViewModel(sl<SearchRepository>()),
      child: const SearchScreen(),
    ),
    AppRouteNames.profile: (_) => const ProfileScreen(),
    AppRouteNames.wishlist: (_) => const WishlistScreen(),
    AppRouteNames.settings: (context) => SettingsScreen(
      openAddress:
          (ModalRoute.of(context)?.settings.arguments
              as Map?)?['openAddress'] ==
          true,
    ),
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
        final productId = args?['productId']?.toString() ?? '';
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) =>
                ProductDetailsViewModel(sl<ProductDetailsRepository>())
                  ..loadProduct(productId),
            child: ProductDetailsScreen(productId: productId),
          ),
        );
      default:
        return null;
    }
  }
}
