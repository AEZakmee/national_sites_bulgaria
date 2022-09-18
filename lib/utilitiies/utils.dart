import 'package:flutter/material.dart';

Future<void> showCustomBottomSheet({
  required BuildContext context,
  required Widget child,
}) =>
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      context: context,
      builder: (context) => child,
    );
