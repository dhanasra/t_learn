
import 'package:flutter/material.dart';
import 'package:t_learn/pages/quiz/view_models/quiz_view_model.dart';
import 'package:t_learn/utils/date_utils.dart';

class SimpleTimer extends StatefulWidget {
  final int duration;
  final ValueChanged<AnimationController> timerController;
  final bool isFormatted;
  final TextStyle textStyle;
  final Alignment align;

  const SimpleTimer({
    Key? key,
    required this.duration,
    required this.timerController,
    this.textStyle = const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
    this.isFormatted = true,
    this.align = Alignment.centerLeft
  }) : super(key: key);

  @override
  State<SimpleTimer> createState() => _SimpleTimerState();
}

class _SimpleTimerState extends State<SimpleTimer> with TickerProviderStateMixin {
  late AnimationController controller;

  String get timerString {
    QuizViewModel.timeTaken = (controller.duration! * controller.value).inSeconds;
    return widget.isFormatted
        ? DateTimeUtils.getTimerFormat(((controller.duration!.inSeconds - (controller.duration! * controller.value).inSeconds)))
        : (controller.duration!.inSeconds - (controller.duration! * controller.value).inSeconds).toString();
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(seconds: widget.duration));
    widget.timerController(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
            alignment: widget.align,
            child: AnimatedBuilder(
                animation: controller,
                builder: (context, child) {
                  return Text(timerString, style: widget.textStyle);
                })
        )
      ],
    );
  }

  @override
  void dispose() {
    controller.stop();
    controller.dispose();
    super.dispose();
  }
}