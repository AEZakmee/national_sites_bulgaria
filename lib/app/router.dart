import 'package:flutter/material.dart';
import 'package:national_sites_bulgaria/screens/splash/splash_screen.dart';

class Routes {
  static const String splash = '/';
}

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      default:
        throw const FormatException('Route not found! Check routes again!');
    }
  }
}
