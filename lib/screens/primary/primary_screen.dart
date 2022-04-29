import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'chats_body.dart';
import 'drawer.dart';
import 'primary_viewmodel.dart';
import 'recomendation_body.dart';
import 'sites_body.dart';

class PrimaryScreen extends StatelessWidget {
  const PrimaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<PrimaryVM>(
        create: (_) => PrimaryVM(),
        child: const Scaffold(
          appBar: MainAppBar(),
          drawer: MainDrawer(),
          body: Body(),
          bottomNavigationBar: BottomNav(),
        ),
      );
}

class MainAppBar extends StatelessWidget with PreferredSizeWidget {
  const MainAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(
              Icons.menu,
              size: 28,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      );

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}

class BottomNav extends StatelessWidget {
  const BottomNav({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CurvedNavigationBar(
      backgroundColor: theme.backgroundColor,
      color: theme.secondaryHeaderColor,
      items: [
        Icon(
          Icons.home,
          size: 30,
          color: theme.primaryColor,
        ),
        Icon(
          Icons.place,
          size: 30,
          color: theme.primaryColor,
        ),
        Icon(
          Icons.chat,
          size: 30,
          color: theme.primaryColor,
        ),
      ],
      onTap: context.read<PrimaryVM>().changePage,
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => PageView(
        controller: context.read<PrimaryVM>().pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          RecommendationBody(),
          SitesBody(),
          ChatsBody(),
        ],
      );
}
