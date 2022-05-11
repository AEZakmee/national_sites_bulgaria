import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../utilitiies/constants.dart';
import '../authentication_viewmodel.dart';

class InputFields extends StatefulWidget {
  const InputFields({Key? key}) : super(key: key);

  @override
  _InputFieldsState createState() => _InputFieldsState();
}

class _InputFieldsState extends State<InputFields> {
  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(
          top: 20,
        ),
        child: Column(
          children: [
            LoginInputField(
              icon: Icons.email,
              hintText: AppLocalizations.of(context)!.emailHint,
              isEmail: true,
              label: AppLocalizations.of(context)!.emailLabel,
              dataField: DataField.email,
            ),
            LoginInputField(
              icon: Icons.lock,
              hintText: AppLocalizations.of(context)!.passwordHint,
              isPassword: true,
              label: AppLocalizations.of(context)!.passwordLabel,
              dataField: DataField.password,
            ),
            AnimatedCrossFade(
              firstChild: const SizedBox.shrink(),
              secondChild: LoginInputField(
                icon: Icons.person,
                hintText: AppLocalizations.of(context)!.usernameHint,
                label: AppLocalizations.of(context)!.usernameLabel,
                dataField: DataField.username,
              ),
              crossFadeState: !Provider.of<AuthVM>(context).isSignUp
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: kAnimDurationLogin,
              reverseDuration: Duration.zero,
            )
          ],
        ),
      );
}

class LoginInputField extends StatelessWidget {
  const LoginInputField({
    required this.label,
    required this.dataField,
    required this.icon,
    required this.hintText,
    this.isPassword = false,
    this.isEmail = false,
    Key? key,
  }) : super(key: key);

  final IconData icon;
  final String hintText;
  final String label;
  final bool isPassword;
  final bool isEmail;
  final DataField dataField;
  @override
  Widget build(BuildContext context) => Consumer<AuthVM>(
        builder: (
          context,
          prov,
          child,
        ) =>
            Padding(
          padding: EdgeInsets.only(
            bottom: prov.buttonPressed
                ? prov.hasError(dataField)
                    ? 10
                    : 15
                : 15,
          ),
          child: TextField(
            obscureText: isPassword,
            showCursor: true,
            onChanged: (String data) => prov.changeData(dataField, data),
            keyboardType:
                isEmail ? TextInputType.emailAddress : TextInputType.text,
            decoration: InputDecoration(
              labelText: label,
              prefixIcon: Icon(
                icon,
                color: Theme.of(context).primaryColor,
              ),
              errorText: prov.buttonPressed
                  ? prov.hasError(dataField)
                      ? prov.getErrorMessage(dataField, context)
                      : null
                  : null,
              hintText: hintText,
            ),
          ),
        ),
      );
}
