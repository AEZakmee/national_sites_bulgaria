import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'authentication_viewmodel.dart';
import 'components/body.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: ChangeNotifierProvider(
          create: (_) => AuthVM(),
          child: const Scaffold(
            body: Body(),
          ),
        ),
      );
}
