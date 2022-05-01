import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../primary_viewmodel.dart';

class SitesBody extends StatelessWidget {
  const SitesBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Center(
        child: GestureDetector(
          onTap: () => context.read<PrimaryVM>().signOut(context),
          child: const Text('Sign out'),
        ),
      );
}
