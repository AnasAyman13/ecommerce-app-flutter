/// Image asset paths used across the app
class AppAssets {
  AppAssets._();

  // ── Base paths ──────────────────────────────────────
  static const String _imagesBase = 'assets/images';

  // ── Logo & Branding ─────────────────────────────────
  static const String logo = '$_imagesBase/logo.png';
  static const String logoWhite = '$_imagesBase/logo_white.png';

  // ── Onboarding ──────────────────────────────────────
  static const String onboarding1 = '$_imagesBase/onboarding_1.png';
  static const String onboarding2 = '$_imagesBase/onboarding_2.png';
  static const String onboarding3 = '$_imagesBase/onboarding_3.png';

  // ── Auth ────────────────────────────────────────────
  static const String googleIcon = '$_imagesBase/google_icon.png';
  static const String appleIcon = '$_imagesBase/apple_icon.png';

  // ── Placeholders ────────────────────────────────────
  static const String productPlaceholder =
      '$_imagesBase/product_placeholder.png';
  static const String avatarPlaceholder = '$_imagesBase/avatar_placeholder.png';

  // ── Empty States ────────────────────────────────────
  static const String emptyCart = '$_imagesBase/empty_cart.png';
  static const String emptyOrders = '$_imagesBase/empty_orders.png';
  static const String emptySearch = '$_imagesBase/empty_search.png';
}
