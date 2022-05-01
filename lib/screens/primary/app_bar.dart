part of 'primary_screen.dart';

class _MainAppBar extends StatelessWidget with PreferredSizeWidget {
  const _MainAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
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