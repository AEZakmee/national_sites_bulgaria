import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {
  late Brightness brightness;
  Future<void> init() async {
    brightness = await getTheme() ??
        SchedulerBinding.instance?.window.platformBrightness ??
        Brightness.light;
  }

  final prefKey = 'theme';

  Future<void> setTheme(Brightness brightness) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setInt(prefKey, brightness.index);
  }

  Future<Brightness?> getTheme() async {
    final pref = await SharedPreferences.getInstance();
    final data = pref.getInt(prefKey);
    if (data == null) {
      return null;
    }
    return Brightness.values[data];
  }
}
