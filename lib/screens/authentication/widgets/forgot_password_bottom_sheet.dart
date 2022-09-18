import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../widgets/bottom_sheet_layout.dart';

class ForgotPassBottomSheet extends StatelessWidget {
  const ForgotPassBottomSheet({
    required this.controller,
    this.onTap,
    Key? key,
  }) : super(key: key);
  final TextEditingController controller;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return BottomSheetLayout(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text.resetLinkText,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: controller,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: text.emailHint,
                prefixIcon: Icon(
                  Icons.email,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: onTap,
                child: Text(
                  text.send,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
