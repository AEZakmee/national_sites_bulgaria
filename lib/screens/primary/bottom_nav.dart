part of 'primary_screen.dart';

class _BottomNav extends StatelessWidget {
  const _BottomNav({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CurvedNavigationBar(
      backgroundColor: Colors.transparent,
      color: theme.secondaryHeaderColor,
      index: context.watch<PrimaryVM>().page,
      items: const [
        Icon(
          Icons.home,
          size: 30,
          color: Colors.black,
        ),
        Icon(
          Icons.place,
          size: 30,
          color: Colors.black,
        ),
        Icon(
          Icons.chat,
          size: 30,
          color: Colors.black,
        ),
      ],
      onTap: context.read<PrimaryVM>().changePage,
    );
  }
}
