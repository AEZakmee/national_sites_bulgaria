import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

import '../../providers/localization_provider.dart';
import '../../providers/theme_provider.dart';
import '../../widgets/page_transition.dart';
import 'drawer_viewmodel.dart';
import 'primary_viewmodel.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ChangeNotifierProvider<DrawerVM>(
      create: (_) => DrawerVM(),
      child: Builder(
        builder: (context) => Drawer(
          child: Container(
            color: theme.backgroundColor,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: theme.brightness.index != 1
                        ? theme.primaryColor
                        : theme.secondaryHeaderColor,
                  ),
                  accountName: Text(
                    'Gosho',
                    style: theme.textTheme.titleLarge,
                  ),
                  accountEmail: Text(
                    'Mail',
                    style: theme.textTheme.bodyLarge,
                  ),
                ),
                DefaultPageTransition(
                  isVertical: true,
                  backgroundColor: theme.backgroundColor,
                  child: getDrawer(context.watch<DrawerVM>().state),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getDrawer(DrawerState state) {
    switch (state) {
      case DrawerState.main:
        return const _MainDrawerBody();
      case DrawerState.language:
        return const _ChangeLanguageDrawerBody();
    }
  }
}

class _ChangeLanguageDrawerBody extends StatelessWidget {
  const _ChangeLanguageDrawerBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Locale locale = context.watch<LocalizationProvider>().getLocale();
    final theme = Theme.of(context);
    return Column(
      children: [
        ListTile(
          leading: Icon(
            Icons.check,
            color: locale.languageCode == 'en'
                ? theme.primaryColor
                : Colors.transparent,
          ),
          title: const Text('English'),
          onTap: () {
            context.read<LocalizationProvider>().setLanguage('en');
            context.read<DrawerVM>().switchState(
                  DrawerState.main,
                );
          },
        ),
        const Divider(),
        ListTile(
          leading: Icon(
            Icons.check,
            color: locale.languageCode == 'bg'
                ? theme.primaryColor
                : Colors.transparent,
          ),
          title: const Text('Български'),
          onTap: () {
            context.read<LocalizationProvider>().setLanguage('bg');
            context.read<DrawerVM>().switchState(
                  DrawerState.main,
                );
          },
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }
}

class _MainDrawerBody extends StatelessWidget {
  const _MainDrawerBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.language),
          title: Text('Change language'),
          onTap: () => context.read<DrawerVM>().switchState(
                DrawerState.language,
              ),
        ),
        ListTile(
          leading: const Icon(Icons.dark_mode),
          title: Text('Dark theme'),
          onTap: () => context.read<ThemeProvider>().switchTheme(),
          trailing: SizedBox(
            height: 28,
            width: 47,
            child: FlutterSwitch(
              width: 47,
              height: 28,
              value: context.watch<ThemeProvider>().isDarkTheme,
              padding: 2,
              activeColor: theme.indicatorColor,
              activeToggleColor: theme.backgroundColor,
              inactiveColor: theme.dividerColor,
              onToggle: (_) => context.read<ThemeProvider>().switchTheme(),
            ),
          ),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.exit_to_app),
          title: Text('Sign out'),
          onTap: () => context.read<PrimaryVM>().signOut(context),
        ),
      ],
    );
  }
}
