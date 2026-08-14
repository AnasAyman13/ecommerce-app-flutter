/// All API endpoint paths
/// Usage: ApiEndpoints.baseUrl + ApiEndpoints.login
class ApiEndpoints {
  ApiEndpoints._();

  // TODO: Replace with your actual API base URL
  static const String baseUrl = 'https://dummyjson.com/products/category/furniture';
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
