import 'package:flutter/material.dart';

import '../../../utilitiies/constants.dart';

class CustomAppBarContainer extends StatelessWidget {
  const CustomAppBarContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        height: MediaQuery.of(context).padding.top,
        decoration: BoxDecoration(
          boxShadow: [kBoxShadow(context)],
          color: Theme.of(context).primaryColor,
        ),
      );
}
