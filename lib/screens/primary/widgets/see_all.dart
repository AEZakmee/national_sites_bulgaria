import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TitleSeeAll extends StatelessWidget {
  const TitleSeeAll({
    required this.text,
    Key? key,
    this.onTap,
    this.hasSeeAllButton = true,
  }) : super(key: key);
  final String text;
  final bool hasSeeAllButton;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          if (hasSeeAllButton) const Spacer(),
          if (hasSeeAllButton)
            GestureDetector(
              onTap: onTap,
              child: Text(
                AppLocalizations.of(context)!.seeAll,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
        ],
      );
}
