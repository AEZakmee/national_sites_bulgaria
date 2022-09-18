import 'package:flutter/material.dart';

class BottomSheetLayout extends StatelessWidget {
  final Widget child;
  final String? title;

  const BottomSheetLayout({required this.child, this.title, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      title ?? '',
                      textAlign: TextAlign.center,
                      style: textTheme.displayMedium?.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(
                    Icons.close,
                    size: 18,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: child,
          )
        ],
      ),
    );
  }
}
