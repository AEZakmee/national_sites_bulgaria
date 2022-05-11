import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class DefaultPageTransition extends StatelessWidget {
  const DefaultPageTransition({
    required this.child,
    Key? key,
    this.reverse = false,
    this.backgroundColor,
    this.isVertical = false,
  }) : super(key: key);

  final Widget child;
  final bool reverse;
  final Color? backgroundColor;
  final bool isVertical;
  @override
  Widget build(BuildContext context) => PageTransitionSwitcher(
        reverse: reverse,
        transitionBuilder: (
          Widget child,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) =>
            SharedAxisTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          fillColor: backgroundColor,
          transitionType: isVertical
              ? SharedAxisTransitionType.vertical
              : SharedAxisTransitionType.horizontal,
          child: child,
        ),
        child: child,
      );
}
