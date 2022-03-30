import 'package:flutter/material.dart';

import '../../app/router.dart';

class SplashVM extends ChangeNotifier {
  bool userIsLogged = false;

  Future<void> checkUser() async {
    await Future.delayed(const Duration(seconds: 3));
    userIsLogged = true;
    notifyListeners();
  }

  Future<void> goToAuthenticationScreen(BuildContext context) async {
    await Navigator.of(context).popAndPushNamed(Routes.auth);
  }
}
