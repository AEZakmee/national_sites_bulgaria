import 'dart:async';

import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';

import '../../../app/router.dart';
import '../../../providers/theme_provider.dart';
import '../../../utilitiies/constants.dart';
import '../../../widgets/locale_switcher.dart';
import '../authentication_viewmodel.dart';
import 'arrow_button.dart';
import 'input_fields.dart';
import 'top_buttons.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _keyboardVisibilityController = KeyboardVisibilityController();
  StreamSubscription<bool>? _sub;
  @override
  void initState() {
    super.initState();
    _sub = _keyboardVisibilityController.onChange.listen((bool visible) {
      Provider.of<AuthVM>(context, listen: false).changeVisibility(visible);
    });
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Consumer<AuthVM>(
        builder: (context, prov, child) => Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: AnimatedContainer(
                duration: kAnimDurationLogin,
                curve: kAnimTypeLogin,
                height: prov.overallPosition + 180,
                decoration: BoxDecoration(
                  gradient: kSplashScreenGradient(context),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: kAnimDurationLogin,
              curve: kAnimTypeLogin,
              right: 0,
              left: 0,
              top: prov.isSignUp
                  ? prov.signUpFieldPosition
                  : prov.loginFieldPosition,
              child: AnimatedContainer(
                duration: kAnimDurationLogin,
                curve: kAnimTypeLogin,
                color: Colors.transparent,
                width: MediaQuery.of(context).size.height - 40,
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Stack(
                  children: [
                    const ArrowButtonBackground(
                      hasShadow: true,
                    ),
                    Column(
                      children: [
                        Card(
                          elevation: 16,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: Column(
                              children: [
                                const ButtonsRow(),
                                const InputFields(),
                                if (prov.hasAuthError)
                                  Center(
                                    child: Text(
                                      prov.authErrorString(context),
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2
                                          ?.copyWith(
                                            color: Theme.of(context).errorColor,
                                          ),
                                    ),
                                  ),
                                const SizedBox(
                                  height: 55,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 55,
                        ),
                      ],
                    ),
                    ArrowButtonBackground(
                      child: ArrowButton(
                        onPress: () => context.read<AuthVM>().signUp(context),
                        isLoading: context.watch<AuthVM>().isLoading,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    LocaleSwitcher(
                      name: 'English',
                      locale: Locale('en'),
                    ),
                    LocaleSwitcher(
                      name: 'Български',
                      locale: Locale('bg'),
                    )
                  ],
                ),
              ),
            ),
            const Align(
              alignment: Alignment.topRight,
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(right: 24),
                  child: CustomDayNightSwitcher(),
                ),
              ),
            ),
          ],
        ),
      );
}

class CustomDayNightSwitcher extends StatelessWidget {
  const CustomDayNightSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeSwitcher = context.watch<ThemeProvider>();
    final theme = Theme.of(context);
    return DayNightSwitcherIcon(
      isDarkModeEnabled: themeSwitcher.isDarkTheme,
      onStateChanged: (isDarkModeEnabled) {
        themeSwitcher.switchTheme();
      },
      dayBackgroundColor: theme.secondaryHeaderColor,
    );
  }
}
