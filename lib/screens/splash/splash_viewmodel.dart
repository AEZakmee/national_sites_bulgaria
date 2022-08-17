import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../app/locator.dart';
import '../../app/router.dart';
import '../../data/sites_repo.dart';

class SplashVM extends ChangeNotifier {
  final FirebaseAuth _auth;
  final DataRepo _dataRepo;
  bool userIsLogged = false;

  SplashVM({
    required auth,
    required dataRepo,
  })  : _auth = auth,
        _dataRepo = dataRepo;

  Future checkUser(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 1, milliseconds: 500));
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
