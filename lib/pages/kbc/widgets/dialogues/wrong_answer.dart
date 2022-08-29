import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:t_learn/app/app.dart';
import 'package:t_learn/app/app_routes.dart';
import 'package:t_learn/pages/kbc/widgets/common/border_container.dart';
import 'package:t_learn/utils/utils.dart';

import '../../../../utils/constants.dart';
import '../../bloc/cubit/rewarded_cubit.dart';


class WrongAnswer extends StatelessWidget {
  final BuildContext pContext;
  final bool isTimeUp;
  const WrongAnswer({
    Key? key,
    required this.pContext,
    this.isTimeUp = false
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
                const Text("DONT GIVEUP", style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Freshman',
                    fontWeight: FontWeight.w500,
                    fontSize: 20
                ),),
                Utils.divider,
                Icon(!isTimeUp
                    ? FontAwesomeIcons.heartPulse
                    : FontAwesomeIcons.solidClock,
                  size: 54,color: Colors.redAccent,),
                Utils.divider,
                const Text("Do you want to continue the game by watch a video ?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14
                  ),),
                Utils.divider,
                Row(
                  children: [
                    Expanded(
                        child: GestureDetector(
                          onTap: ()=>const App().setNavigation(context, AppRoutes.kbcMain),
                          child: const CircleContainer(
                              width:  120,
                              height: 50,
                              child: Text("GIVE UP",
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
                          onTap: (){
                            pContext.read<RewardedCubit>().showRewardedAd();
                          },
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
        ));
  }
}
