import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/locator.dart';
import '../../app/router.dart';
import '../../data/models/chat_room.dart';
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

  bool get isFavourite => _dataRepo.user.favouriteSites.contains(site.uid);

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
    if (favorites.contains(site.uid)) {
      favorites.remove(site.uid);
    } else {
      favorites.add(site.uid);
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

  Future<void> openChat(BuildContext context) async {
    final bool exists = await _fireStoreService.checkRoomExists(site.uid);
    if (!exists) {
      await _fireStoreService.createRoom(ChatRoom(
        siteId: site.uid,
        roomName: site.info.name,
        roomImage: site.image.url,
        imageHash: site.image.hash,
        lastMessage: '',
        lastMessageTime: DateTime.now(),
      ));
    }
    final freshRoom = await _fireStoreService.fetchRoom(site.uid);
    await Navigator.of(context).pushNamed(
      Routes.chat,
      arguments: ChatRoomArguments(freshRoom),
    );
  }
}
