import 'package:flutter/material.dart';

class ColoredSafeArea extends StatelessWidget {
  const ColoredSafeArea({
    required this.child,
    Key? key,
    this.topColor,
    this.bottomColor,
  }) : super(key: key);

  final Color? topColor;
  final Color? bottomColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final halfSize = MediaQuery.of(context).size.height / 2;
    return Stack(
      children: [
        Positioned(
          top: 0,
          right: 0,
          left: 0,
          child: Container(
            height: halfSize,
            color: topColor,
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Container(
            height: halfSize,
            color: bottomColor ?? topColor,
          ),
        ),
        Positioned.fill(
          child: SafeArea(
            child: child,
          ),
        ),
      ],
    );
  }
}
