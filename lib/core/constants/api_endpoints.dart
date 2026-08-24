/// All API endpoint paths
/// Usage: ApiEndpoints.baseUrl + ApiEndpoints.login
class ApiEndpoints {
  ApiEndpoints._();

  /// Override in production with `--dart-define=API_BASE_URL=https://.../`.
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://dummyjson.com/',
  );

  static const String allProducts = 'products';
  static const String productCategories = 'products/categories';
  static const String searchProducts = 'products/search';
  static String productsByCategory(String category) =>
      'products/category/${Uri.encodeComponent(category)}';
  static String productById(String id) => 'products/$id';
  //static const String productById =
  // ── Auth ────────────────────────────────────────────
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';

  // ── Home ────────────────────────────────────────────
  static const String home = '/home';
  static const String banners = '/banners';

  // ── Categories ──────────────────────────────────────
  static const String categories = '/categories';

  // ── Products ────────────────────────────────────────
  static const String products = '/products';
  static String productDetails(String id) => '/products/$id';

  // ── Search ──────────────────────────────────────────
  static const String search = '/search';

  // ── Cart ────────────────────────────────────────────
  static const String cart = '/cart';
  static const String addToCart = '/cart/add';
  static String removeFromCart(String id) => '/cart/remove/$id';
  static String updateCartItem(String id) => '/cart/update/$id';

  // ── Wishlist ────────────────────────────────────────
  static const String wishlist = '/wishlist';
  static String wishlistItem(String productId) => '/wishlist/$productId';

  // ── Orders ──────────────────────────────────────────
  static const String orders = '/orders';
  static String orderDetails(String id) => '/orders/$id';

  // ── Profile ─────────────────────────────────────────
  static const String profile = '/profile';
  static const String updateProfile = '/profile/update';
  static const String updatePassword = '/profile/password';
}
