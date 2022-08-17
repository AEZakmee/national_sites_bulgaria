import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../app/locator.dart';
import '../../app/router.dart';
import '../../data/sites_repo.dart';

GlobalKey<CurvedNavigationBarState> bottomNavKye = GlobalKey();

class PrimaryVM extends ChangeNotifier {
  final DataRepo _dataRepo;
  final FirebaseAuth _auth;

  PrimaryVM({
    required auth,
    required dataRepo,
  })  : _auth = auth,
        _dataRepo = dataRepo;

  final pageController = PageController();

  int page = 0;

  void init() => _dataRepo.initListeners();

  void onDispose() => _dataRepo.cancelListeners();

  void signOut(BuildContext context) {
    _auth.signOut();
    Navigator.of(context).pushReplacementNamed(Routes.auth);
  }

  void changePage(int index) {
    page = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
  }

  void changePageNotifier(int index) {
    final CurvedNavigationBarState? navBarState = bottomNavKye.currentState;
    navBarState?.setPage(index);
  }
}
