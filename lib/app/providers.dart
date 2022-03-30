import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/localization_provider.dart';
import '../providers/theme_provider.dart';

class ProviderInitializer extends StatelessWidget {
  const ProviderInitializer({required this.child, Key? key}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ThemeProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => LocalizationProvider(),
          ),
        ],
        child: child,
      );
}
