import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {
  late Brightness brightness;
  late FlexScheme flexScheme;

  Future<void> init() async {
    brightness =
        await getTheme() ?? SchedulerBinding.instance.window.platformBrightness;
    flexScheme = await getScheme() ?? FlexScheme.money;
  }

  final prefKey = 'theme';
  final schemePrefKey = 'scheme';

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

  Future<void> setScheme(FlexScheme scheme) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setInt(schemePrefKey, scheme.index);
  }

  Future<FlexScheme?> getScheme() async {
    final pref = await SharedPreferences.getInstance();
    final data = pref.getInt(schemePrefKey);
    if (data == null) {
      return null;
    }
    return FlexScheme.values[data];
  }
}
