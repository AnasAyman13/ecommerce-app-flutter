import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleController extends ValueNotifier<Locale> {
  LocaleController._() : super(const Locale('en'));
  static final instance = LocaleController._();

  void restore(SharedPreferences preferences) {
    value = Locale(
      preferences.getString('selected_language') == 'ar' ? 'ar' : 'en',
    );
  }

  Future<void> setArabic(bool enabled, SharedPreferences preferences) async {
    value = Locale(enabled ? 'ar' : 'en');
    await preferences.setString('selected_language', enabled ? 'ar' : 'en');
  }
}

String tr(BuildContext context, String english, String arabic) =>
    Localizations.localeOf(context).languageCode == 'ar' ? arabic : english;

String localizedCategory(BuildContext context, String name) {
  if (Localizations.localeOf(context).languageCode != 'ar') return name;
  const map = {
    'furniture': 'أثاث',
    'home-decoration': 'ديكور منزلي',
    'kitchen-accessories': 'إكسسوارات المطبخ',
    'Living Room': 'غرفة المعيشة',
    'Bedroom': 'غرفة النوم',
    'Chairs': 'كراسي',
    'Lighting': 'إضاءة',
    'Dining': 'غرفة الطعام',
    'Kitchen': 'المطبخ',
  };
  return map[name] ?? name;
}

String localizedProductName(BuildContext context, String name) {
  if (Localizations.localeOf(context).languageCode != 'ar') return name;
  var result = name;
  const words = {
    'bed': 'سرير',
    'sofa': 'أريكة',
    'table': 'طاولة',
    'chair': 'كرسي',
    'cabinet': 'خزانة',
    'lamp': 'مصباح',
    'light': 'إضاءة',
    'shelf': 'رف',
    'mirror': 'مرآة',
    'bench': 'مقعد',
    'wardrobe': 'دولاب',
    'desk': 'مكتب',
    'kitchen': 'مطبخ',
    'wood': 'خشب',
    'dining': 'طعام',
    'office': 'مكتب',
  };
  words.forEach((english, arabic) {
    result = result.replaceAll(RegExp(english, caseSensitive: false), arabic);
  });
  return result;
}
