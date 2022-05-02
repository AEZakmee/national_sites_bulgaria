import 'package:flutter/material.dart';
import '../screens/authentication/authentication_screen.dart';
import '../screens/info/info_screen.dart';
import '../screens/primary/primary_screen.dart';
import '../screens/splash/splash_screen.dart';

class Routes {
  static const String splash = '/';
  static const String auth = '/auth';
  static const String primary = '/primary';
  static const String info = '/info';
}

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case Routes.auth:
        return MaterialPageRoute(
          builder: (_) => const AuthenticationScreen(),
        );
      case Routes.primary:
        return MaterialPageRoute(
          builder: (_) => const PrimaryScreen(),
        );
      case Routes.info:
        final args = settings.arguments as InfoScreenArguments;
        return MaterialPageRoute(
          builder: (_) => InfoScreen(
            uid: args.uid,
          ),
        );
      default:
        throw const FormatException('Route not found! Check routes again!');
    }
  }
}

class InfoScreenArguments {
  final String uid;
  InfoScreenArguments(this.uid);
}
