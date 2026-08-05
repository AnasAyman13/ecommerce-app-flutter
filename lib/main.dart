import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/theme/app_theme.dart';

import 'routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context,child){
            return MaterialApp(
              debugShowCheckedModeBanner: false,

              title: 'NORR',

              initialRoute: AppRoutes.splash,

              routes: AppRoutes.routes,
            );
      },
    );

  }
}
