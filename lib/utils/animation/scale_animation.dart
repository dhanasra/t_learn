
import 'package:flutter/material.dart';
import 'package:t_learn/utils/constants.dart';

class SplashWidget extends StatefulWidget {
  const SplashWidget({Key? key}) : super(key: key);

  @override
  State<SplashWidget> createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> with TickerProviderStateMixin {

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  )..repeat(reverse: true);

  late final Animation<double> animation = Tween<double>(begin: 0.5, end: 1).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceIn,
  ));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
        scale: animation,
        child: Container(
          width: _controller.value>0.5 ? 100 : 150,
          height: _controller.value>0.5 ? 100 : 150,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("${appAssets}app_logo.png"),
                  fit: BoxFit.fill
              )
          ),
        )
    );
  }
}
