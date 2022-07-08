import 'package:flutter/material.dart';

import 'app_breakpoints.dart';

enum ResponsiveLayoutSize {
  small,
  medium,
  large
}

class ResponsiveLayoutBuilder extends StatelessWidget {
  const ResponsiveLayoutBuilder({
    Key? key,
    required this.small,
    this.medium,
    required this.large,
  }) : super(key: key);

  final Widget small;
  final Widget? medium;
  final Widget large;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;

        if (screenWidth <= AppBreakpoints.small) {
          return small;
        }

        if (screenWidth <= AppBreakpoints.medium) {
          return medium ?? large;
        }

        if (screenWidth <= AppBreakpoints.large) {
          return large;
        }

        return large;
      },
    );
  }
}
