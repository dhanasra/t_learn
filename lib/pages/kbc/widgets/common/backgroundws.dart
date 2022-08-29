
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:t_learn/utils/constants.dart';

class BackgroundWS extends StatelessWidget {
  final Widget child;
  final LinearGradient? gradient;
  const BackgroundWS({
    Key? key,
    required this.child,
    this.gradient = appGradient
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(gradient: gradient),
        child: Stack(
          children: [
            ...List.generate(30, (index) => generateStar(context)).toList(),
            child
          ],
        ));
  }

  Widget generateStar(context){
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    int top = Random().nextInt(h.toInt());
    int bottom = Random().nextInt(h.toInt());
    int right = Random().nextInt(w.toInt());
    int left = Random().nextInt(w.toInt());

    return Positioned(
        top: top.toDouble(),
        bottom: bottom.toDouble(),
        left: left.toDouble(),
        right: right.toDouble(),
        child: const Icon(Icons.star, size: 8, color: Colors.white,)
    );
  }
}

