import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/localization_provider.dart';

class LocaleSwitcher extends StatelessWidget {
  const LocaleSwitcher({
    required this.name,
    required this.locale,
    Key? key,
  }) : super(key: key);
  final String name;
  final Locale locale;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(12.0),
        child: InkWell(
          onTap: () => context
              .read<LocalizationProvider>()
              .setLanguage(locale.languageCode),
          child: Text(
            name,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
      );
}
