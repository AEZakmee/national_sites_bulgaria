import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'primary_viewmodel.dart';

class PrimaryScreen extends StatelessWidget {
  const PrimaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<PrimaryVM>(
        create: (_) => PrimaryVM(),
        child: Builder(
          builder: (context) => Scaffold(
            body: Center(
              child: GestureDetector(
                onTap: () => context.read<PrimaryVM>().signOut(context),
                child: const Text('Sign out'),
              ),
            ),
          ),
        ),
      );
}
