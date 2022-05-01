import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../app/locator.dart';
import '../../app/router.dart';
import '../../data/sites_repo.dart';

class SplashVM extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _dataRepo = locator<DataRepo>();
  bool userIsLogged = false;

  Future checkUser(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));
    if (_auth.currentUser != null) {
      await _dataRepo.init();
      return Navigator.of(context).pushReplacementNamed(Routes.primary);
    } else {
      userIsLogged = true;
    }
    notifyListeners();
  }

  void goToAuthenticationScreen(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(Routes.auth);
  }
}
