import 'package:flutter/material.dart';
import '../screens/authentication/authentication_screen.dart';
import '../screens/splash/splash_screen.dart';

class Routes {
  static const String splash = '/';
  static const String auth = '/auth';
}

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.auth:
        return MaterialPageRoute(builder: (_) => const AuthenticationScreen());
      default:
        throw const FormatException('Route not found! Check routes again!');
    }
  }
}
