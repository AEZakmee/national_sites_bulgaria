import 'dart:async';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';

import '../../../app/locator.dart';
import '../../../app/router.dart';
import '../../../data/models/chat_room.dart';
import '../../../data/models/site.dart';
import '../../../data/sites_repo.dart';
import '../../../services/firestore_service.dart';

class RecommendationVM extends ChangeNotifier {
  final DataRepo _dataRepo;
  final FirestoreService _fireStoreService;

  RecommendationVM({
    required fireStoreService,
    required dataRepo,
  })  : _fireStoreService = fireStoreService,
        _dataRepo = dataRepo;

  final textController = TextEditingController();
  String textFilter = '';

  List<Site> displaySites = [];

  void updateFilter() {
    textFilter = textController.text;
    EasyDebounce.debounce(
      'search-key',
      const Duration(milliseconds: 300),
      notifyListeners,
    );
  }

  bool get shouldShowSearch => textFilter.length > 2;

  final imageViewController = PageController();

  List<Site> get filteredSites => _dataRepo.sites
      .where(
        (element) => element.info.name.contains(textFilter),
      )
      .toList();

  List<Site> get sites => _dataRepo.sites;
  List<String> get _favourites => _dataRepo.user.favouriteSites;

  List<Site> get favouriteSites =>
      sites.where((element) => _favourites.contains(element.uid)).toList();

  Stream<List<ChatRoom>> get roomsStream => _fireStoreService.roomsStream();

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

  Future<void> openChat(BuildContext context, String id) async {
    final freshRoom = await _fireStoreService.fetchRoom(id);
    await Navigator.of(context).pushNamed(
      Routes.chat,
      arguments: ChatRoomArguments(freshRoom),
    );
  }

  Future<void> init() async {
    startTimer();
    displaySites
      ..addAll(_dataRepo.sites)
      ..shuffle();
    _dataRepo.addListener(notifyListeners);
  }

  void onDispose() {
    _timer?.cancel();
    _dataRepo.removeListener(notifyListeners);
  }
}
