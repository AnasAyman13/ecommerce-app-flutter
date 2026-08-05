import 'package:flutter/material.dart';

extension StringExtensions on String {
  /// Capitalizes first letter
  String get capitalize =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';

  /// Returns true if string is a valid email
  bool get isValidEmail => RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  ).hasMatch(this);

  /// Returns true if string is a valid phone number (basic)
  bool get isValidPhone => RegExp(r'^\+?[\d\s-]{8,15}$').hasMatch(this);

  /// Returns true if string is not null and not empty
  bool get isNotNullOrEmpty => trim().isNotEmpty;
}

extension IntExtensions on int {
  /// Formats price with currency symbol
  String toPrice({String currency = 'EGP'}) =>
      '$currency ${toStringAsFixed(0)}';
}

extension DoubleExtensions on double {
  /// Formats price with currency symbol
  String toPrice({String currency = 'EGP'}) =>
      '$currency ${toStringAsFixed(2)}';
}

extension ContextExtensions on BuildContext {
  /// Screen width
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Screen height
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Navigate to a named route
  void navigateTo(String routeName, {Object? arguments}) =>
      Navigator.pushNamed(this, routeName, arguments: arguments);

  /// Navigate and replace current route
  void navigateAndReplace(String routeName, {Object? arguments}) =>
      Navigator.pushReplacementNamed(this, routeName, arguments: arguments);

  /// Pop back
  void pop([Object? result]) => Navigator.pop(this, result);

  /// Show snackbar
  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Theme shortcut
  ThemeData get theme => Theme.of(this);

  /// ColorScheme shortcut
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}

extension ListExtensions<T> on List<T> {
  /// Returns true if list is not null and not empty
  bool get isNotNullOrEmpty => isNotEmpty;

  /// Safe get — returns null instead of throwing on out-of-bounds
  T? safeGet(int index) => (index >= 0 && index < length) ? this[index] : null;
}
