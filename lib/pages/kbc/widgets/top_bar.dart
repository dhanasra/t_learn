import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:t_learn/pages/kbc/bloc/kbc_bloc/kbc_bloc.dart';
import 'package:t_learn/pages/kbc/views/kbc_view_model.dart';
import 'package:t_learn/pages/kbc/widgets/countdown_timer.dart';

import '../../quiz/widgets/simple_timer.dart';
import 'dialogues/wrong_answer.dart';

class TopBar extends StatefulWidget {
  final VoidCallback onBack;
  const TopBar({
    Key? key,
    required this.onBack
  }) : super(key: key);

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 35, 10, 20),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
            child: GestureDetector(
              onTap: widget.onBack,
              child: const Icon(FontAwesomeIcons.doorOpen, color: Colors.redAccent, size: 26,),
            )
          ),

          const CountdownTimer(),

          // BlocBuilder<KbcBloc, KbcState>(
          //     builder: (_,state){
          //       return Padding(
          //         padding: const EdgeInsets.fromLTRB(0,30,0,0),
          //         child: SimpleTimer(
          //             timerController: (AnimationController controller) {
          //               controller.forward();
          //               controller.addStatusListener((status) {
          //                 if(state is KbcFinish){
          //                   print("--------------------------------------------------");
          //                   controller.stop(canceled: true);
          //                   controller.dispose();
          //                 }
          //                 if(status == AnimationStatus.completed){
          //                   Future.delayed(
          //                       const Duration(milliseconds: 500),
          //                           ()=>showDialog(
          //                           context: context,
          //                           barrierDismissible: false,
          //                           builder: (_)=> WrongAnswer(
          //                             isTimeUp: true,
          //                             pContext: context,)));
          //                 }
          //               });
          //             },
          //             duration: 30,
          //             isFormatted: false,
          //             align: Alignment.center,
          //             textStyle: const TextStyle(
          //                 color: Colors.white,
          //                 fontFamily: 'Freshman',
          //                 fontWeight: FontWeight.w500,
          //                 fontSize: 32
          //             )
          //         ),
          //       );
          //     },
          // ),

          Align(
            alignment: Alignment.centerRight,
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text("\u20B9 ${KBCViewModel.amount}", style: const TextStyle(
                  color: Colors.yellow,
                  fontFamily: 'Freshman',
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                )
            )),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    print("...........................................................disposing");
    super.dispose();
  }
}
