import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../app/router.dart';
import '../../../data/models/chat_room.dart';
import '../../../utilitiies/constants.dart';
import '../../../utilitiies/extensions.dart';
import '../../../widgets/cached_image.dart';
import '../../../widgets/keyboard_dismisser.dart';
import '../../../widgets/staggered_animations.dart';
import '../../../widgets/viewmodel_builder.dart';
import '../primary_viewmodel.dart';
import '../widgets/see_all.dart';
import '../widgets/site_card.dart';
import 'recommendation_viewmodel.dart';

const double topImageHeight = 280;

class RecommendationBody extends StatelessWidget {
  const RecommendationBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => KeyboardDismissOnTap(
        child: ViewModelBuilder<RecommendationVM>(
          viewModelBuilder: RecommendationVM.new,
          onModelReady: (viewModel) => viewModel.init(),
          onDispose: (viewModel) => viewModel.onDispose(),
          builder: (context, _) => const _Body(),
        ),
      );
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          const Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: _TopImagePageView(),
          ),
          Positioned(
            top: topImageHeight,
            right: 0,
            left: 0,
            child: SizedBox(
              height: MediaQuery.of(context).size.height - topImageHeight,
              child: context.watch<RecommendationVM>().shouldShowSearch
                  ? ListView(
                      padding: EdgeInsets.zero,
                      children: const [
                        SizedBox(height: 40),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: _SitesFilteredColumn(),
                        ),
                        SizedBox(height: 100),
                      ],
                    )
                  : ListView(
                      padding: EdgeInsets.zero,
                      children: const [
                        SizedBox(height: 40),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: _FavouritesRow(),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: _ActiveChats(),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: _SitesColumn(),
                        ),
                        SizedBox(height: 100),
                      ],
                    ),
            ),
          ),
          const Positioned(
            top: topImageHeight - 25,
            left: 20,
            right: 20,
            child: _SearchField(),
          )
        ],
      );
}

class _TopImagePageView extends StatelessWidget {
  const _TopImagePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<RecommendationVM>();
    return SizedBox(
      height: topImageHeight,
      child: PageView(
        controller: viewModel.imageViewController,
        children: [
          ...List.generate(
            viewModel.displaySites.length.clamp(0, 10),
            (index) => GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(
                Routes.info,
                arguments: InfoScreenArguments(
                  viewModel.displaySites[index].uid,
                ),
              ),
              child: Stack(
                children: [
                  SizedBox(
                    height: topImageHeight,
                    width: double.infinity,
                    child: CustomCachedImage(
                      url: viewModel.displaySites[index].image.url,
                      hash: viewModel.displaySites[index].image.hash,
                    ),
                  ),
                  Container(
                    height: topImageHeight,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: kOverImageGradient(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Theme.of(context).dividerColor.withOpacity(0.5),
          ),
          boxShadow: Theme.of(context).isDarkTheme(context)
              ? null
              : [kSearchFieldShadow(context)],
        ),
        child: TextFormField(
          controller: context.read<RecommendationVM>().textController,
          onChanged: (_) => context.read<RecommendationVM>().updateFilter(),
          decoration: InputDecoration(
            enabledBorder: kTextFieldBorder(),
            focusedBorder: kTextFieldBorder(),
            border: kTextFieldBorder(),
            hintText: AppLocalizations.of(context)!.searchSites,
            fillColor: Theme.of(context).backgroundColor,
            suffixIcon: Icon(
              Icons.search,
              color: Theme.of(context).primaryColor,
              size: 30,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
          ),
        ),
      );
}

class _SitesColumn extends StatelessWidget {
  const _SitesColumn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<RecommendationVM>();
    if (viewModel.sites.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      children: [
        TitleSeeAll(
          text: AppLocalizations.of(context)!.sites,
          onTap: () => context.read<PrimaryVM>().changePageNotifier(1),
        ),
        const SizedBox(height: 10),
        StaggeredColumnScale(
          count: viewModel.sites.length.clamp(0, 5),
          children: [
            ...List.generate(
              viewModel.sites.length,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SiteCardWhole(
                  site: viewModel.sites[index],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SitesFilteredColumn extends StatelessWidget {
  const _SitesFilteredColumn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<RecommendationVM>();
    if (viewModel.sites.isEmpty) {
      return const SizedBox.shrink();
    }
    final sites = viewModel.filteredSites;
    return Column(
      children: [
        StaggeredColumnScale(
          count: sites.length,
          children: [
            ...List.generate(
              sites.length,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SiteCardWhole(
                  site: sites[index],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _FavouritesRow extends StatelessWidget {
  const _FavouritesRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<RecommendationVM>();
    if (viewModel.favouriteSites.isEmpty) {
      return const SizedBox.shrink();
    }
    final sites = viewModel.favouriteSites.take(5).toList();
    return Column(
      children: [
        TitleSeeAll(
          text: AppLocalizations.of(context)!.favSites,
          hasSeeAllButton: false,
        ),
        const SizedBox(height: 10),
        StaggeredRow(
          count: sites.length,
          children: List.generate(
            sites.length,
            (index) => Padding(
              padding: const EdgeInsets.only(right: 10),
              child: SiteCard(
                site: sites[index],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class _ActiveChats extends StatelessWidget {
  const _ActiveChats({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<RecommendationVM>();
    return Column(
      children: [
        TitleSeeAll(
          text: AppLocalizations.of(context)!.activeRooms,
          onTap: () => context.read<PrimaryVM>().changePageNotifier(2),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: StreamBuilder<List<ChatRoom>>(
            stream: viewModel.roomsStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox.shrink();
              }
              final rooms = snapshot.data!.take(7).toList();
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: StaggeredRow(
                  count: rooms.length,
                  children: List.generate(
                    rooms.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(
                        bottom: 5,
                        right: 10,
                      ),
                      child: InkWell(
                        onTap: () => viewModel.openChat(
                          context,
                          rooms[index].siteId,
                        ),
                        child: SizedBox(
                          height: 60,
                          width: 60,
                          child: CustomCachedImage(
                            url: rooms[index].roomImage,
                            hash: rooms[index].imageHash,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
