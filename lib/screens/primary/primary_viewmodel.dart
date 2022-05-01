import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../app/locator.dart';
import '../../app/router.dart';
import '../../data/sites_repo.dart';

class PrimaryVM extends ChangeNotifier {
  final _dataRepo = locator<DataRepo>();
  final _auth = FirebaseAuth.instance;

  final pageController = PageController();

  int get page {
    if (pageController.hasClients) {
      return pageController.page!.toInt();
    }
    return 0;
  }

  void init() => _dataRepo.initListeners();

  void onDispose() => _dataRepo.cancelListeners();

  void signOut(BuildContext context) {
    _auth.signOut();
    Navigator.of(context).pushReplacementNamed(Routes.auth);
  }

  void changePage(int index) {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
  }
}
