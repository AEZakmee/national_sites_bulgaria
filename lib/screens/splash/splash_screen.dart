import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../app/locator.dart';
import '../../utilitiies/constants.dart';
import '../authentication/widgets/arrow_button.dart';
import 'splash_viewmodel.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (_) => locator<SplashVM>(),
        child: const SplashScreenAnimation(),
      );
}

class SplashScreenAnimation extends StatefulWidget {
  const SplashScreenAnimation({Key? key}) : super(key: key);

  @override
  State<SplashScreenAnimation> createState() => _SplashScreenAnimationState();
}

class _SplashScreenAnimationState extends State<SplashScreenAnimation>
    with TickerProviderStateMixin {
  late AnimationController _animController;

  @override
  void initState() {
    super.initState();
    context.read<SplashVM>().checkUser(context);
    _animController = AnimationController(vsync: this);
    _animController.addListener(() {
      if (_animController.value > 0.2) {
        _animController.stop();
      }
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final showWelcomeScreen = context.watch<SplashVM>().userIsLogged;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          Flexible(
            child: AnimatedContainer(
              duration: const Duration(seconds: 1),
              height: screenHeight,
              decoration: BoxDecoration(
                gradient: kSplashScreenGradient(context),
                boxShadow: [kBoxShadow(context)],
                borderRadius: showWelcomeScreen
                    ? const BorderRadius.only(
                        bottomRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30))
                    : null,
              ),
              child: Lottie.asset(
                'assets/lottie/bulgaria_flag.json',
                controller: _animController,
                onLoaded: (composition) {
                  _animController
                    ..duration = composition.duration
                    ..forward();
                },
              ),
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            transitionBuilder: (Widget child, Animation<double> animation) =>
                SizeTransition(
              sizeFactor: animation,
              axisAlignment: -1,
              child: child,
            ),
            child: showWelcomeScreen
                ? const _BottomPart()
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

class _BottomPart extends StatelessWidget {
  const _BottomPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 30.0),
              Text(
                AppLocalizations.of(context)!.welcomeLabel,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 30.0),
              Text(
                AppLocalizations.of(context)!.welcomeDescription,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 30.0),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  height: 115,
                  width: 115,
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: ArrowButton(
                      onPress: () => context
                          .read<SplashVM>()
                          .goToAuthenticationScreen(context),
                      isLoading: false,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
            ],
          ),
        ),
      );
}
