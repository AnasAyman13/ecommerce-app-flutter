import 'package:flutter/material.dart';
import 'theme_mode_controller.dart';

class AppColors {
  AppColors._();

  // Main palette
  static Color get primaryMaroon =>
      ThemeModeController.instance.value == ThemeMode.dark
      ? const Color(0xFFE58A86)
      : const Color(0xFF832C31);
  static const Color darkBrown = Color(0xFF35211E);
  static const Color goldAccent = Color(0xFFBB8A52);
  static const Color starYellow = Color(0xFFFFBA00);
  static const Color taupeGrey = Color(0xFF9B8B7E);

  // Background and surfaces
  static Color get bgCream =>
      ThemeModeController.instance.value == ThemeMode.dark
      ? const Color(0xFF171311)
      : const Color(0xFFFAF6F0);
  static const Color white = Color(0xFFFFFFFF);
  static Color get cardBg =>
      ThemeModeController.instance.value == ThemeMode.dark
      ? const Color(0xFF2A2422)
      : Colors.white;

  // Dark brown / charcoal
  static Color get darkBrownPill =>
      ThemeModeController.instance.value == ThemeMode.dark
      ? const Color(0xFFE0B4A8)
      : const Color(0xFF35211E);

  // Maroon / Burgundy primary accents
  static Color get maroonBadge => primaryMaroon;

  // Light pill backgrounds
  static Color get lightPillBg =>
      ThemeModeController.instance.value == ThemeMode.dark
      ? const Color(0xFF39302D)
      : const Color(0xFFF5EFE8);
  static Color get lightBorder =>
      ThemeModeController.instance.value == ThemeMode.dark
      ? const Color(0xFF554943)
      : const Color(0xFFECE4DC);

  // Text colors
  static Color get textDark =>
      ThemeModeController.instance.value == ThemeMode.dark
      ? const Color(0xFFF4EDE8)
      : const Color(0xFF35211E);
  static Color get textGrey =>
      ThemeModeController.instance.value == ThemeMode.dark
      ? const Color(0xFFC8BDB7)
      : const Color(0xFF8E8278);
  static Color get textLightGrey =>
      ThemeModeController.instance.value == ThemeMode.dark
      ? const Color(0xFFB8ACA6)
      : const Color(0xFFA1958C);

  // Status colors & chips
  // Delivered status (mint green)
  static const Color mintGreen = Color(0xFF2A9383);
  static const Color mintBg = Color(0xFFE6F5F2);

  // Out for Delivery status (amber/gold)
  static const Color amberGold = Color(0xFFB07D3E);
  static const Color amberBg = Color(0xFFF8F2E6);

  // Cancelled status (pink/red)
  static const Color cancelledRed = Color(0xFFC04245);
  static const Color cancelledBg = Color(0xFFFBEAEB);

  // Compatibility aliases
  static Color get backgroundLight => bgCream;
  static Color get background => bgCream;
  static Color get primary => primaryMaroon;
  static Color get header => primaryMaroon;
  static const Color gold = Color(0xFFBB8A52);
  static const Color black = Colors.black87;
  static const Color grey = Colors.grey;
}
