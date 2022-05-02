import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/locator.dart';
import '../../data/models/site.dart';
import '../../data/sites_repo.dart';
import '../../services/firestore_service.dart';

class InfoVM extends ChangeNotifier {
  final _fireStoreService = locator<FireStoreService>();
  final _dataRepo = locator<DataRepo>();

  final String uid;

  InfoVM(this.uid);

  late Site site;

  late int userRating;

  void updateRating(double rating) {
    userRating = rating.toInt();
  }

  void init() {
    updateSite();
    loadRating();
    _dataRepo.addListener(updateSite);
  }

  void loadRating() {
    final data = _dataRepo.user.votes.where(
      (element) => element.siteId == site.uid,
    );
    if (data.isEmpty) {
      userRating = 0;
    } else {
      userRating = data.first.vote;
    }
  }

  void onDispose() {
    _dataRepo.removeListener(updateSite);
  }

  void updateSite() {
    site = _dataRepo.sites.firstWhere(
      (element) => element.uid == uid,
    );
    notifyListeners();
  }

  bool get isFavourite =>
      _dataRepo.user.favouriteSites.contains(site.siteNumber);

  double get rating {
    if (site.rating.count == 0) {
      return 0;
    }
    return site.rating.total / site.rating.count;
  }

  void openNavigation() {
    final url =
        'https://www.google.com/maps?saddr=My+Location&daddr=${site.coordinates.lat},${site.coordinates.lng}';
    launchUrl(Uri.parse(url));
  }

  Future<void> toggleFavorite() async {
    final favorites = _dataRepo.user.favouriteSites;
    if (favorites.contains(site.siteNumber)) {
      favorites.remove(site.siteNumber);
    } else {
      favorites.add(site.siteNumber);
    }
    await _fireStoreService.updateUserFavourites(
      favorites,
    );
  }

  Future<void> voteSite() async {
    if (userRating == 0) {
      return;
    }
    await _fireStoreService.voteForSite(site.uid, userRating);
  }
}
