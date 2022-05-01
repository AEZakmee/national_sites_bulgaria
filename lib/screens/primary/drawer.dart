part of 'primary_screen.dart';

class _MainDrawer extends StatelessWidget {
  const _MainDrawer({
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
              shrinkWrap: true,
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
      case DrawerState.scheme:
        return const _ChangeSchemeDrawerBody();
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
          height: 120,
        ),
      ],
    );
  }
}

class _ChangeSchemeDrawerBody extends StatelessWidget {
  const _ChangeSchemeDrawerBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final theme = Theme.of(context);
    return Column(
      children: [
        ...List.generate(
          FlexScheme.values.length,
          (index) => ListTile(
            leading: Icon(
              Icons.check,
              color: themeProvider.scheme == FlexScheme.values[index]
                  ? theme.primaryColor
                  : Colors.transparent,
            ),
            title: Text(FlexScheme.values[index].name.parseThemeName()),
            onTap: () {
              context.read<ThemeProvider>().updateScheme(
                    FlexScheme.values[index],
                  );
              context.read<DrawerVM>().switchState(
                    DrawerState.main,
                  );
            },
            trailing: Theme(
              data: theme.isDarkTheme(context)
                  ? FlexColorScheme.dark(scheme: FlexScheme.values[index])
                      .toTheme
                  : FlexColorScheme.light(scheme: FlexScheme.values[index])
                      .toTheme,
              child: Builder(
                builder: (context) => Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 120,
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
        ListTile(
          leading: const Icon(Icons.color_lens),
          title: Text('Color Scheme'),
          onTap: () => context.read<DrawerVM>().switchState(
                DrawerState.scheme,
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
