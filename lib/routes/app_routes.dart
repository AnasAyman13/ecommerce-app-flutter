import 'package:flutter/material.dart';

import '../features/auth/views/screens/login_screen.dart';
import '../features/auth/views/screens/register_screen.dart';

class AppRoutes {

  static const String login = '/login';

  static const String register = '/register';


  static Map<String, WidgetBuilder> routes = {

    login: (context) => const LoginScreen(),

    register: (context) => const RegisterScreen(),

  };

}