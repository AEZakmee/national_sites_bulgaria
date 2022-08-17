import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

import '../../app/locator.dart';
import '../../providers/localization_provider.dart';
import '../../providers/theme_provider.dart';
import '../../utilitiies/extensions.dart';
import '../../widgets/cached_image.dart';
import '../../widgets/page_transition.dart';
import '../../widgets/viewmodel_builder.dart';
import 'drawer_viewmodel.dart';
import 'primary_viewmodel.dart';
import 'recommendation/recomendation_body.dart';
import 'rooms/rooms_body.dart';
import 'sites/sites_body.dart';

part 'app_bar.dart';
part 'bottom_nav.dart';
part 'drawer.dart';

class PrimaryScreen extends StatelessWidget {
  const PrimaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ViewModelBuilder<PrimaryVM>(
        viewModelBuilder: locator<PrimaryVM>,
        onModelReady: (viewModel) => viewModel.init(),
        onDispose: (viewModel) => viewModel.onDispose(),
        builder: (context, _) => const Scaffold(
          extendBodyBehindAppBar: true,
          extendBody: true,
          appBar: _MainAppBar(),
          drawer: _MainDrawer(),
          body: _Body(),
          bottomNavigationBar: _BottomNav(),
        ),
      );
}

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => PageView(
        controller: context.read<PrimaryVM>().pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          RecommendationBody(),
          SitesBody(),
          RoomsBody(),
        ],
      );
}
