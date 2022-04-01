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

//Add products page
OutlineInputBorder kOutlineBorderAdd(context) => OutlineInputBorder(
      borderRadius: kInputFiledBorderRadiusAdd,
      borderSide: BorderSide(color: Theme.of(context).accentColor),
    );
OutlineInputBorder kEnabledOutlineBorderAdd(context) => OutlineInputBorder(
      borderRadius: kInputFiledBorderRadiusAdd,
      borderSide: BorderSide(color: Theme.of(context).accentColor),
    );
OutlineInputBorder kErrorOutlineBorderAdd(context) => OutlineInputBorder(
      borderRadius: kInputFiledBorderRadiusAdd,
      borderSide: BorderSide(color: Theme.of(context).errorColor),
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

LinearGradient kArrowButtonGradient(context) => LinearGradient(
      colors: [
        Theme.of(context).primaryColor,
        Theme.of(context).secondaryHeaderColor
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
