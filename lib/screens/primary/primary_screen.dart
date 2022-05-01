import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

import '../../providers/localization_provider.dart';
import '../../providers/theme_provider.dart';
import '../../widgets/page_transition.dart';
import '../../widgets/viewmodel_builder.dart';
import 'drawer_viewmodel.dart';
import 'primary_viewmodel.dart';
import 'recommendation/recomendation_body.dart';
import 'rooms/rooms_body.dart';
import 'sites/sites_body.dart';

part 'drawer.dart';
part 'app_bar.dart';
part 'bottom_nav.dart';

class PrimaryScreen extends StatelessWidget {
  const PrimaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ViewModelBuilder<PrimaryVM>(
        viewModelBuilder: PrimaryVM.new,
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
