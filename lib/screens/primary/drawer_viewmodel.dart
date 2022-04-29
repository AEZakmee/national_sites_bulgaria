import 'package:flutter/cupertino.dart';

enum DrawerState {
  main,
  language,
}

class DrawerVM extends ChangeNotifier {
  DrawerState state = DrawerState.main;

  void switchState(DrawerState state) {
    this.state = state;
    notifyListeners();
  }
}
