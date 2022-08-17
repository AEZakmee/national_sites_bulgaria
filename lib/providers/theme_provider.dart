import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

import '../app/locator.dart';
import '../services/theme_service.dart';

class ThemeProvider extends ChangeNotifier {
  final ThemeService themeService;

  ThemeProvider({required this.themeService});

  bool get isDarkTheme => themeService.brightness == Brightness.dark;

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

  Future<void> updateScheme(FlexScheme scheme) async {
    themeService.flexScheme = scheme;
    await themeService.setScheme(scheme);
    notifyListeners();
  }

  FlexScheme get scheme => themeService.flexScheme;

  ThemeData getTheme() {
    switch (themeService.brightness) {
      case Brightness.light:
        return FlexColorScheme.light(scheme: themeService.flexScheme).toTheme;
      case Brightness.dark:
        return FlexColorScheme.dark(scheme: themeService.flexScheme).toTheme;
    }
  }
}
