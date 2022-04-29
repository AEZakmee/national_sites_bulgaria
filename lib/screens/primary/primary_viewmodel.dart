import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../app/router.dart';

class PrimaryVM extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;

  final pageController = PageController();

  void signOut(BuildContext context) {
    _auth.signOut();
    Navigator.of(context).pushReplacementNamed(Routes.auth);
  }

  void changePage(int index) => pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.linear,
      );
}
