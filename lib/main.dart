import 'package:ecommerce_app/core/di/service_locator.dart';
import 'package:ecommerce_app/core/models/favorite_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/cart/view_models/cart_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(FavoriteItemModelAdapter());
  await Hive.openBox<FavoriteItemModel>('favorites_box');

  await initServiceLocator();

  runApp(
    BlocProvider(
      create: (_) => CartViewModel(),
      child: const NorrApp(),
    ),
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
      builder: (_, __) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'NORR',
        theme: AppTheme.lightTheme,
        initialRoute: AppRouter.initialRoute,
        routes: AppRouter.routes,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}