import 'package:flutter/cupertino.dart';

import '../../app/locator.dart';
import '../../data/models/app_user.dart';
import '../../data/sites_repo.dart';

enum DrawerState {
  main,
  language,
  scheme,
}

class DrawerVM extends ChangeNotifier {
  final _dataRepo = locator<DataRepo>();
  DrawerState state = DrawerState.main;

  AppUser get user => _dataRepo.user;

  void switchState(DrawerState state) {
    this.state = state;
    notifyListeners();
  }
}
