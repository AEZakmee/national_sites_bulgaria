import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../../utilitiies/constants.dart';
import '../../../widgets/cached_image.dart';
import '../../primary/recommendation/recomendation_body.dart';
import '../info_viewmodel.dart';

class TopStack extends StatelessWidget {
  const TopStack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
        height: topImageHeight,
        width: double.infinity,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomRight,
          children: [
            SizedBox(
              height: topImageHeight,
              width: double.infinity,
              child: CustomCachedImage(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                ),
                hash: context.watch<InfoVM>().site.image.hash,
                url: context.watch<InfoVM>().site.image.url,
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
      );
}

class ButtonsRow extends StatelessWidget {
  const ButtonsRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        height: 80,
        width: 300,
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(
              25,
            ),
            bottomLeft: Radius.circular(
              25,
            ),
          ),
          boxShadow: [kBoxShadow(context)],
        ),
        child: const RatingsRow(),
      );
}

class RatingsRow extends StatelessWidget {
  const RatingsRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Consumer<InfoVM>(
        builder: (context, viewModel, _) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Expanded(
              child: _VoteStar(),
            ),
            Expanded(
              child: GestureDetector(
                onTap: viewModel.toggleFavorite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FittedBox(
                      child: Icon(
                        viewModel.isFavourite
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                        color: viewModel.isFavourite
                            ? Colors.redAccent
                            : Theme.of(context).dividerColor,
                        size: 45,
                      ),
                    ),
                    FittedBox(
                      child: Text(
                        viewModel.isFavourite ? 'Remove' : 'Add',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: viewModel.openNavigation,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FittedBox(
                      child: Icon(
                        Icons.navigation,
                        color: Theme.of(context).primaryColor,
                        size: 45,
                      ),
                    ),
                    FittedBox(
                      child: Text(
                        'Navigation',
                        style: Theme.of(context).textTheme.bodyMedium,
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

class _VoteStar extends StatefulWidget {
  const _VoteStar({
    Key? key,
  }) : super(key: key);

  @override
  State<_VoteStar> createState() => _VoteStarState();
}

class _VoteStarState extends State<_VoteStar> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<InfoVM>();
    return GestureDetector(
      onTap: () => _openVoteMenu(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const FittedBox(
            child: Icon(
              Icons.star,
              color: Colors.amber,
              size: 45,
            ),
          ),
          FittedBox(
            child: Text(
              viewModel.rating != 0
                  ? '${viewModel.rating.toStringAsFixed(1)}/5'
                  : 'No votes',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          if (viewModel.site.rating.count != 0)
            Text('${viewModel.site.rating.count} votes')
        ],
      ),
    );
  }

  void _openVoteMenu(BuildContext context) {
    final viewModel = context.read<InfoVM>();
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Container(
          color: Colors.transparent,
          child: Container(
            height: 300,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                const Spacer(),
                RatingBar.builder(
                  initialRating: viewModel.userRating.toDouble(),
                  minRating: 1,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemSize: 45,
                  glowColor: Theme.of(context).primaryColor,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: viewModel.updateRating,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 30,
                  ),
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        viewModel.voteSite();
                        Navigator.of(context).pop();
                      },
                      child: const Text('Vote'),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
