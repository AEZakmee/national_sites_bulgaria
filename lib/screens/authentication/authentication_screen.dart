import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'authentication_viewmodel.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Provider(
          create: (_) => AuthVM(),
          child: Center(
            child: Text('asd'),
          ),
        ),
      );
}
