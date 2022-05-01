import 'package:flutter/material.dart';

extension ThemeExtension on ThemeData {
  bool isDarkTheme(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;
}

extension NameExtension on String {
  String parseThemeName() {
    final beforeNonLeadingCapitalLetter = RegExp('(?=(?!^)[A-Z])');
    final data = split(beforeNonLeadingCapitalLetter);
    return data.map((e) => e[0].toUpperCase() + e.substring(1)).join(' ');
  }
}
