import 'package:flutter/material.dart';

import '../../../../utils/constants.dart';

class CircleContainer extends StatelessWidget {
  final Widget child;
  final double height;
  final double width;
  final Gradient gradient;
  final VoidCallback? onTap;

  const CircleContainer({
    Key? key,
    required this.child,
    this.height = 55,
    this.width = 55,
    this.onTap,
    this.gradient = rg
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            gradient: gradient,
            border: Border.all(color: Colors.white)
        ),
        child: child,
      ),
    );
  }
}

