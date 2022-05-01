import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../app/locator.dart';
import '../services/firestore_service.dart';
import 'models/app_user.dart';
import 'models/site.dart';

class DataRepo extends ChangeNotifier {
  final FireStoreService _fireStoreService = locator<FireStoreService>();
  final _auth = FirebaseAuth.instance;

  String get userId => _auth.currentUser!.uid;

  late AppUser user;
  late List<Site> sites;

  late StreamSubscription<AppUser> _userSubscription;

  late StreamSubscription<List<Site>> _sitesSubscription;

  Future<void> init() async {
    user = await _fireStoreService.fetchUser(userId);
    sites = await _fireStoreService.fetchSites();
  }

  void userListener() {
    _userSubscription =
        _fireStoreService.userStream(_auth.currentUser!.uid).listen((value) {
      user = value;
      notifyListeners();
    });
  }

  void sitesListener() {
    _sitesSubscription = _fireStoreService.sitesStream().listen((value) {
      sites = value;
      notifyListeners();
    });
  }

  void initListeners() {
    userListener();
    sitesListener();
  }

  void cancelListeners() {
    _userSubscription.cancel();
    _sitesSubscription.cancel();
  }
}
