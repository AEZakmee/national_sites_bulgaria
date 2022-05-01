import 'package:flutter/material.dart';

extension ThemeExtension on ThemeData {
  bool isDarkTheme(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;
}
