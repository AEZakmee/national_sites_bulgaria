import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../app/locator.dart';
import '../../../data/models/site.dart';
import '../../../data/sites_repo.dart';

enum SortType {
  number,
  rating,
  maxRating,
  favorites,
  town,
}

class SitesVM extends ChangeNotifier {
  final DataRepo _dataRepo;

  SitesVM({
    required dataRepo,
  }) : _dataRepo = dataRepo;

  SortType type = SortType.number;

  bool isSelected(SortType type) => type == this.type;

  void changeType(SortType type) {
    this.type = type;
    notifyListeners();
  }

  List<Site> get sites => _dataRepo.sites;

  List<Site> get sortedSites {
    final copyList = [...sites];
    switch (type) {
      case SortType.rating:
        copyList.sort((a, b) => a.rating.total > b.rating.total ? 0 : 1);
        break;
      case SortType.maxRating:
        copyList.sort((a, b) => a.rating.count > b.rating.count ? 0 : 1);
        break;
      case SortType.number:
        copyList.sort((a, b) => a.siteNumber.compareTo(b.siteNumber));
        break;
      case SortType.favorites:
        final favorites = _dataRepo.user.favouriteSites;
        copyList.removeWhere((element) => !favorites.contains(element.uid));
        break;
      case SortType.town:
        copyList.sort((a, b) => a.info.town.compareTo(b.info.town));
    }
    return copyList;
  }

  String getSortTranslation(SortType type, BuildContext context) {
    switch (type) {
      case SortType.rating:
        return AppLocalizations.of(context)!.rating;
      case SortType.maxRating:
        return AppLocalizations.of(context)!.popularity;
      case SortType.number:
        return AppLocalizations.of(context)!.siteNumber;
      case SortType.favorites:
        return AppLocalizations.of(context)!.favorites;
      case SortType.town:
        return AppLocalizations.of(context)!.town;
    }
  }
}
