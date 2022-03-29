import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

import '../app/locator.dart';
import '../services/theme_service.dart';

class ThemeProvider extends ChangeNotifier {
  final themeService = locator<ThemeService>();

  Future<void> switchTheme() async {
    switch (themeService.brightness) {
      case Brightness.light:
        themeService.brightness = Brightness.dark;
        await themeService.setTheme(Brightness.dark);
        break;
      case Brightness.dark:
        themeService.brightness = Brightness.light;
        await themeService.setTheme(Brightness.light);
        break;
    }
    notifyListeners();
  }

  ThemeData getTheme() {
    switch (themeService.brightness) {
      case Brightness.light:
        return FlexColorScheme.light(scheme: FlexScheme.barossa).toTheme;
      case Brightness.dark:
        return FlexColorScheme.dark(scheme: FlexScheme.barossa).toTheme;
    }
  }
}
