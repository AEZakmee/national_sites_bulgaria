import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'splash_viewmodel.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (_) => SplashVM(),
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
    context.read<SplashVM>().checkUser();
    _animController = AnimationController(vsync: this);
    _animController.addListener(() {
      if (_animController.value > 0.5) {
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
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Flexible(
            child: AnimatedContainer(
              duration: const Duration(seconds: 1),
              height: showWelcomeScreen ? screenHeight / 1.9 : screenHeight,
              decoration: BoxDecoration(
                color: Colors.black87,
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
              const Text(
                'Welcome to Conquer Bulgaria',
                style: TextStyle(
                    fontSize: 27.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              const SizedBox(height: 30.0),
              const Text(
                'If you like traveling this is the place for you!\nIn here you will learn about the Bulgarian culture.\n'
                'Explore the nature and visit the hundred national sites of Bulgaria.',
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 30.0),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: 85.0,
                  width: 85.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black87, width: 2.0),
                  ),
                  child: GestureDetector(
                    onTap: () => context
                        .read<SplashVM>()
                        .goToAuthenticationScreen(context),
                    child: const Icon(
                      Icons.chevron_right,
                      size: 50.0,
                      color: Colors.black87,
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
