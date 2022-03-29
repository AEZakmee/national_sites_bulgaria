import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class LocalizationService {
  late String languageCode;
  Future<void> init() async {
    final String deviceLocaleCode = Platform.localeName.split('_')[0];
    languageCode = await getLocale() ?? deviceLocaleCode;
  }

  final prefKey = 'locale';

  Future<void> setLocale(String code) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(prefKey, code);
  }

  Future<String?> getLocale() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(prefKey);
  }
}
