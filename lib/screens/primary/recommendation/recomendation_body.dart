import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utilitiies/constants.dart';
import '../../../utilitiies/extensions.dart';
import '../../../widgets/cached_image.dart';
import '../../../widgets/keyboard_dismisser.dart';
import '../../../widgets/staggered_animations.dart';
import '../../../widgets/viewmodel_builder.dart';
import '../widgets/see_all.dart';
import '../widgets/site_card.dart';
import 'recommendation_viewmodel.dart';

const double _topImageHeight = 280;

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
            top: _topImageHeight,
            right: 10,
            left: 10,
            child: SizedBox(
              height: MediaQuery.of(context).size.height - _topImageHeight,
              child: ListView(
                padding: EdgeInsets.zero,
                children: const [
                  SizedBox(height: 35),
                  _FavouritesRow(),
                  _SitesColumn(),
                  SizedBox(height: 100),
                ],
              ),
            ),
          ),
          const Positioned(
            top: _topImageHeight - 25,
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
      height: _topImageHeight,
      child: PageView(
        controller: viewModel.imageViewController,
        children: [
          ...List.generate(
            viewModel.sites.length,
            (index) => Stack(
              children: [
                SizedBox(
                  height: _topImageHeight,
                  width: double.infinity,
                  child: CustomCachedImage(
                    url: viewModel.sites[index].image.url,
                    hash: viewModel.sites[index].image.hash,
                  ),
                ),
                Container(
                  height: _topImageHeight,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: kOverImageGradient(),
                  ),
                ),
              ],
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
          decoration: InputDecoration(
            enabledBorder: kTextFieldBorder(),
            focusedBorder: kTextFieldBorder(),
            border: kTextFieldBorder(),
            hintText: 'Search sites',
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
        const TitleSeeAll(
          text: 'National sites',
        ),
        const SizedBox(height: 10),
        StaggeredColumnScale(
          count: viewModel.sites.length,
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
    return Column(
      children: [
        const TitleSeeAll(
          text: 'Favourite sites',
          hasSeeAllButton: false,
        ),
        const SizedBox(height: 10),
        StaggeredRow(
          count: viewModel.favouriteSites.length,
          children: List.generate(
            viewModel.favouriteSites.length,
            (index) => Padding(
              padding: const EdgeInsets.only(right: 10),
              child: SiteCard(
                site: viewModel.favouriteSites[index],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
