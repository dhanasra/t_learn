import 'package:flutter/material.dart';
import 'package:t_learn/app/app.dart';
import 'package:t_learn/pages/kbc/views/kbc_view_model.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/utils.dart';
import '../common/border_container.dart';

class LeaveKBC extends StatelessWidget {
  final VoidCallback onLeaveClick;
  const LeaveKBC({
    Key? key,
    required this.onLeaveClick
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async=>false,
        child: Dialog(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)
          ),
          child: Container(
            decoration: BoxDecoration(
                gradient: rg1,
                borderRadius: BorderRadius.circular(blunt),
                border: Border.all(color: Colors.white, width: 2)
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("LEAVE GAME", style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Freshman',
                    fontWeight: FontWeight.w500,
                    fontSize: 20
                ),),
                Utils.divider,
                Text("Are you sure you want to take \u20B9 ${KBCViewModel.amount}? and leave the game ?",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14
                  ),),
                Utils.divider,
                Row(
                  children: [
                    Expanded(
                        child: GestureDetector(
                          onTap: onLeaveClick,
                          child: const CircleContainer(
                              width:  120,
                              height: 50,
                              child: Text("LEAVE",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14
                                  ))),
                        )
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                        child: GestureDetector(
                          onTap: ()=>const App().setBackNavigation(context),
                          child: const CircleContainer(
                              width:  120,
                              height: 50,
                              gradient: rgSuccess,
                              child: Text("CONTINUE",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14
                                  ))),
                        ))
                  ],
                )
              ],
            ),
          ),
        )
    );
  }
}
