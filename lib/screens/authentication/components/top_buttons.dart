import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../utilitiies/constants.dart';
import '../authentication_viewmodel.dart';

class ButtonsRow extends StatelessWidget {
  const ButtonsRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(15),
        child: Consumer<AuthVM>(
            builder: (context, loginProv, child) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RowButton(
                      buttonText: AppLocalizations.of(context)!.login,
                      isSelectedButton: loginProv.loginType == LoginType.login,
                      onTap: () => loginProv.toggleLoginType(),
                    ),
                    RowButton(
                      buttonText: AppLocalizations.of(context)!.signup,
                      isSelectedButton: loginProv.loginType == LoginType.signUp,
                      onTap: () => loginProv.toggleLoginType(),
                    ),
                  ],
                )),
      );
}

class RowButton extends StatelessWidget {
  const RowButton({
    required this.buttonText,
    required this.isSelectedButton,
    Key? key,
    this.onTap,
  }) : super(key: key);

  final String buttonText;
  final bool isSelectedButton;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Text(
              buttonText,
              style: isSelectedButton
                  ? Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(color: Theme.of(context).primaryColor)
                  : Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(color: Theme.of(context).disabledColor),
            ),
            AnimatedContainer(
              duration: kAnimDurationLogin,
              curve: kAnimTypeLogin,
              margin: const EdgeInsets.only(top: 3),
              height: 2,
              width: isSelectedButton ? 60 : 0,
              color: Theme.of(context).secondaryHeaderColor,
            )
          ],
        ),
      );
}
