import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app/app.dart';
import 'app/locator.dart';
import 'app/providers.dart';
import 'services/localization_service.dart';
import 'services/theme_service.dart';

Future<void> initApp() async {
  setup();
  final themeService = locator<ThemeService>();
  await themeService.init();
  final localizationService = locator<LocalizationService>();
  await localizationService.init();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  await initApp();
  runApp(const ProviderInitializer(child: MyApp()));
}
