import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_learn/pages/kbc/bloc/kbc_bloc/kbc_bloc.dart';

import 'dialogues/wrong_answer.dart';

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({Key? key}) : super(key: key);

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  Timer? countdownTimer;
  Duration duration = const Duration(seconds: 30);

  @override
  void initState() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (_)=>setCountDown());
    super.initState();
  }

  void setCountDown() {
    setState(() {
      final seconds = duration.inSeconds - 1;
      if (seconds < 0) {
        Future.delayed(
            const Duration(milliseconds: 500),
                ()=>showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_)=> WrongAnswer(
                  isTimeUp: true,
                  pContext: context)));
        print(1);
        countdownTimer!.cancel();
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  void stopTimer() {
    Future.delayed(const Duration(seconds: 0),(){
      setState(() => countdownTimer!.cancel());
    });
  }

  void resetTimer() {
    stopTimer();
    setState(() => duration = const Duration(seconds: 30));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KbcBloc, KbcState>(
        builder: (_,state){
          if(state is KbcFinish || state is TimerStopped){
            stopTimer();
          }
          return Container(
            alignment: Alignment.center,
            child: Text( duration.inSeconds.toString(),
              style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Freshman',
                  fontWeight: FontWeight.w500,
                  fontSize: 32
              ),
            ),
          );
        },
    );
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
  }
}
