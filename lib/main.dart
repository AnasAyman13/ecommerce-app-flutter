import 'package:ecommerce_app/core/di/service_locator.dart';
import 'package:ecommerce_app/core/models/favorite_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_mode_controller.dart';
import 'core/theme/locale_controller.dart';
import 'core/widgets/app_backdrop.dart';
import 'features/cart/view_models/cart_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(FavoriteItemModelAdapter());
  await Hive.openBox<FavoriteItemModel>('favorites_box');

  await initServiceLocator();
  ThemeModeController.instance.restore(sl());
  LocaleController.instance.restore(sl());

  runApp(
    BlocProvider(create: (_) => CartViewModel(sl()), child: const NorrApp()),
  );
}

class NorrApp extends StatelessWidget {
  const NorrApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => ValueListenableBuilder<Locale>(
        valueListenable: LocaleController.instance,
        builder: (context, locale, _) => ValueListenableBuilder<ThemeMode>(
          valueListenable: ThemeModeController.instance,
          builder: (context, mode, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'NORR',
            theme: AppTheme.lightTheme,
            darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
              scaffoldBackgroundColor: Colors.transparent,
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF9E3D43),
                brightness: Brightness.dark,
              ),
            ),
            themeMode: mode,
            locale: locale,
            supportedLocales: const [Locale('en'), Locale('ar')],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            initialRoute: AppRouter.initialRoute,
            routes: AppRouter.routes,
            onGenerateRoute: AppRouter.onGenerateRoute,
            builder: (context, page) => Directionality(
              textDirection: locale.languageCode == 'ar'
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              child: AppBackdrop(child: page ?? const SizedBox.shrink()),
            ),
          ),
        ),
      ),
    );
  }
}
