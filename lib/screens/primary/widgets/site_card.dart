import 'package:flutter/material.dart';

import '../../../app/router.dart';
import '../../../data/models/site.dart';
import '../../../utilitiies/constants.dart';
import '../../../utilitiies/extensions.dart';
import '../../../widgets/cached_image.dart';

class SiteCard extends StatelessWidget {
  const SiteCard({
    required this.site,
    Key? key,
  }) : super(key: key);

  final Site site;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(
          Routes.info,
          arguments: InfoScreenArguments(site.uid),
        ),
        child: Container(
          width: 140,
          height: 145,
          padding: Theme.of(context).isDarkTheme(context)
              ? const EdgeInsets.all(1)
              : null,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            boxShadow: [kBoxShadowLite(context)],
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Theme.of(context).isDarkTheme(context)
                ? Border.all(
                    color: Theme.of(context).dividerColor.withOpacity(0.5),
                  )
                : null,
          ),
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 16 / 10,
                child: CustomCachedImage(
                  url: site.image.url,
                  hash: site.image.hash,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  site.info.name,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      );
}

class SiteCardWhole extends StatelessWidget {
  const SiteCardWhole({
    required this.site,
    Key? key,
  }) : super(key: key);

  final Site site;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(
          Routes.info,
          arguments: InfoScreenArguments(site.uid),
        ),
        child: Container(
          width: double.infinity,
          height: 110,
          padding: Theme.of(context).isDarkTheme(context)
              ? const EdgeInsets.all(1)
              : null,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            boxShadow: [kBoxShadowLite(context)],
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Theme.of(context).isDarkTheme(context)
                ? Border.all(
                    color: Theme.of(context).dividerColor.withOpacity(0.5),
                  )
                : null,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 16 / 10,
                child: CustomCachedImage(
                  url: site.image.url,
                  hash: site.image.hash,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Text(
                        site.info.name,
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const Spacer(),
                          Text(
                            site.info.town,
                            style: Theme.of(context).textTheme.bodyMedium,
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
