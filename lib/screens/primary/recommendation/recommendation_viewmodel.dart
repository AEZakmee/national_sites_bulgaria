import 'dart:async';

import 'package:flutter/material.dart';

import '../../../app/locator.dart';
import '../../../data/models/site.dart';
import '../../../data/sites_repo.dart';

class RecommendationVM extends ChangeNotifier {
  final _dataRepo = locator<DataRepo>();

  final imageViewController = PageController();

  List<Site> get sites => _dataRepo.sites;
  List<String> get _favourites => _dataRepo.user.places;

  List<Site> get favouriteSites => sites
      .where((element) => _favourites.contains(element.siteNumber))
      .toList();

  Timer? _timer;

  void startTimer() {
    const seconds = Duration(seconds: 5);
    _timer = Timer.periodic(seconds, (Timer timer) => updateMainPicture());
  }

  Future<void> updateMainPicture() async {
    if (!imageViewController.hasClients) {
      return;
    }

    final currentPage = imageViewController.page?.toInt();
    if (currentPage != null) {
      if (currentPage == sites.length - 1) {
        await imageViewController.animateToPage(
          0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeIn,
        );
      } else {
        await imageViewController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeIn,
        );
      }
    }
  }

  Future<void> init() async {
    startTimer();
    _dataRepo.addListener(notifyListeners);
  }

  void onDispose() {
    _timer?.cancel();
    _dataRepo.removeListener(notifyListeners);
  }
}
