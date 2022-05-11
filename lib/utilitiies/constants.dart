import 'package:flutter/material.dart';

final kBorderRadius = BorderRadius.circular(5);
final kBorderRadiusLite = BorderRadius.circular(5);
final kInputFiledBorderRadius = BorderRadius.circular(35);
final kInputFiledBorderRadiusAdd = BorderRadius.circular(5);

const kAnimTypeLogin = Curves.easeIn;
const kAnimDurationLogin = Duration(milliseconds: 400);

//Box decorations
BoxShadow kBoxShadowLite(context) => BoxShadow(
      color: Theme.of(context).shadowColor.withOpacity(0.2),
      blurRadius: 5,
      spreadRadius: 2,
    );
BoxShadow kBoxShadow(context) => BoxShadow(
      color: Theme.of(context).shadowColor.withOpacity(0.5),
      blurRadius: 15,
      spreadRadius: 5,
    );
BoxShadow kBoxShadowLiteTop(context) => BoxShadow(
      color: Theme.of(context).shadowColor.withOpacity(0.1),
      blurRadius: 2,
      offset: Offset(0, -3),
      spreadRadius: 2,
    );

BoxShadow kSearchFieldShadow(context) => BoxShadow(
      offset: const Offset(3, 3),
      blurRadius: 10,
      color: Theme.of(context).dividerColor.withOpacity(0.7),
      spreadRadius: -1,
    );

OutlineInputBorder kTextFieldBorder() => OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      gapPadding: 10,
      borderRadius: BorderRadius.circular(5),
    );

LinearGradient kLoginBackgroundGradient(context) => LinearGradient(
      colors: [
        Theme.of(context).secondaryHeaderColor,
        Theme.of(context).primaryColorDark,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

LinearGradient kSplashScreenGradient(context) => LinearGradient(
      colors: [
        Colors.black87,
        Theme.of(context).primaryColorDark,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

LinearGradient kOverImageGradient() => const LinearGradient(
      colors: [
        Colors.black87,
        Colors.transparent,
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

LinearGradient kArrowButtonGradient(context) => LinearGradient(
      colors: [
        Theme.of(context).primaryColor,
        Theme.of(context).secondaryHeaderColor
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
