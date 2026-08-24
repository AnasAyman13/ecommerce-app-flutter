import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModeController extends ValueNotifier<ThemeMode> {
  ThemeModeController._() : super(ThemeMode.light);

  static final instance = ThemeModeController._();

  void restore(SharedPreferences preferences) {
    value = preferences.getBool('dark_mode') == true
        ? ThemeMode.dark
        : ThemeMode.light;
  }

  Future<void> setDark(bool enabled, SharedPreferences preferences) async {
    value = enabled ? ThemeMode.dark : ThemeMode.light;
    await preferences.setBool('dark_mode', enabled);
  }
}
