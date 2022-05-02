import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utilitiies/constants.dart';
import '../../../widgets/staggered_animations.dart';
import '../../../widgets/viewmodel_builder.dart';
import '../widgets/custom_appbar_container.dart';
import '../widgets/site_card.dart';
import 'sites_viewmodel.dart';

class SitesBody extends StatelessWidget {
  const SitesBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ViewModelBuilder<SitesVM>(
        viewModelBuilder: SitesVM.new,
        builder: (context, _) => const _Body(),
      );
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Consumer<SitesVM>(
        builder: (context, viewModel, _) {
          final sites = viewModel.sortedSites;
          return Column(
            children: [
              const CustomAppBarContainer(),
              const SizedBox(height: 5),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      SortType.values.length,
                      (index) => GestureDetector(
                        onTap: () =>
                            viewModel.changeType(SortType.values[index]),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              color:
                                  viewModel.isSelected(SortType.values[index])
                                      ? Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.7)
                                      : Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.2),
                              boxShadow: [kBoxShadowLite(context)],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                              child: Text(
                                viewModel.getSortTranslation(
                                    SortType.values[index], context),
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: StaggeredListView(
                  count: sites.length,
                  child: (index) => Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 5,
                    ),
                    child: SiteCardWhole(
                      site: sites[index],
                    ),
                  ),
                ),
              )
            ],
          );
        },
      );
}
