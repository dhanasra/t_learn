import 'package:flutter/material.dart';

import '../../../../app/app.dart';
import '../../../../app/app_routes.dart';
import '../../../../utils/constants.dart';
import 'border_text.dart';

class StylizedButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;

  StylizedButton({
    Key? key,
    required this.child,
    this.onPressed,
  }) : super(key: key);

  final _buttonPressedVn = ValueNotifier<bool>(false);

  void _animate() {
    _buttonPressedVn.value = true;
  }

  Future<void> _reverseAnimate() async {
    await Future.delayed(Duration(milliseconds: 50));
    _buttonPressedVn.value = false;
  }

  void _onPressConfirm(BuildContext context) {
    onPressed?.call();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTapDown: (_) => _animate(),
        onTapUp: (_) async {
          await _reverseAnimate();
          _onPressConfirm(context);
        },
        onTapCancel: _reverseAnimate,
        child: ValueListenableBuilder(
          valueListenable: _buttonPressedVn,
          child: child,
          builder: (_, bool isPressed, Widget? child) {
            return AnimatedScale(
              scale: isPressed ? 0.90 : 1.0,
              curve: Curves.elasticOut,
              duration: Duration(milliseconds: 50),
              child: child,
            );
          },
        ),
      ),
    );
  }
}


class StylizedContainer extends StatefulWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color color;

  const StylizedContainer({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 36.0,
      vertical: 12.0,
    ),
    this.margin,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  State<StylizedContainer> createState() => _StylizedContainerState();
}

class _StylizedContainerState extends State<StylizedContainer> {
  final globalKey = GlobalKey();

  Widget? topReflectionWidget;

  void _buildReflectionWidget(_) {
    final size = globalKey.currentContext?.size;
    if (size == null) return;

    setState(() {
      topReflectionWidget = Container(
        margin: const EdgeInsets.all(5.0),
        height: size.height * 0.50,
        width: size.width,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.60),
          borderRadius: BorderRadius.circular(8.0),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_buildReflectionWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Transform.translate(
        offset: const Offset(0.0, -6.0),
        child: Container(
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              // reflection widget
              topReflectionWidget ?? const SizedBox.shrink(),

              // child widget
              Container(
                margin: widget.padding,
                key: globalKey,
                child: widget.child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IcButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final EdgeInsets padding;
  final double iconSize;
  const IcButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    this.padding = const EdgeInsets.all(16.0),
    this.iconSize = 20
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StylizedButton(
      onPressed: onPressed,
      child: StylizedContainer(
        padding: padding,
        color: const Color(0xffF0F0F0),
        child: Icon(
          icon,
          size: iconSize,
          color: primaryColor,
        ),
      ),
    );
  }
}
