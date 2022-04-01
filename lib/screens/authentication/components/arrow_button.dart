import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../utilitiies/constants.dart';

class ArrowButtonBackground extends StatelessWidget {
  const ArrowButtonBackground({
    this.child,
    Key? key,
    this.hasShadow = false,
    this.bottom = 0,
  }) : super(key: key);
  final bool hasShadow;
  final Widget? child;
  final double bottom;
  @override
  Widget build(BuildContext context) => AnimatedPositioned(
        duration: kAnimDurationLogin,
        curve: kAnimTypeLogin,
        right: 0,
        left: 0,
        bottom: bottom,
        child: Center(
          child: Container(
            height: 105,
            width: 105,
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              shape: BoxShape.circle,
              boxShadow: [if (hasShadow) kBoxShadow(context)],
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: child,
            ),
          ),
        ),
      );
}

class ArrowButton extends StatelessWidget {
  const ArrowButton({
    required this.isLoading,
    Key? key,
    this.onPress,
  }) : super(key: key);
  final VoidCallback? onPress;
  final bool isLoading;
  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onPress,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: kArrowButtonGradient(context),
            boxShadow: [kBoxShadow(context)],
            shape: BoxShape.circle,
          ),
          child: !isLoading
              ? Icon(
                  Icons.arrow_forward,
                  color: Theme.of(context).buttonTheme.colorScheme!.onPrimary,
                  size: 40,
                )
              : Padding(
                  padding: const EdgeInsets.all(10),
                  child: SpinKitFadingCircle(
                    color: Theme.of(context).buttonTheme.colorScheme!.onPrimary,
                  ),
                ),
        ),
      );
}
