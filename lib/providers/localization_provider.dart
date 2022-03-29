import 'package:flutter/material.dart';

import '../app/locator.dart';
import '../services/localization_service.dart';

enum supportedLocales {
  en,
  bg,
}

class LocalizationProvider extends ChangeNotifier {
  final themeService = locator<LocalizationService>();

  Future<void> setLanguage(String data) async {
    themeService.languageCode = data;
    await themeService.setLocale(data);
    notifyListeners();
  }

  Locale getLocale() => Locale(themeService.languageCode);

  List<Locale> getSupportedLocales() => List.generate(
        supportedLocales.values.length,
        (index) => Locale(supportedLocales.values[index].name),
      );
}
