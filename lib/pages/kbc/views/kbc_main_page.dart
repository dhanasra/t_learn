
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:t_learn/app/app.dart';
import 'package:t_learn/app/app_routes.dart';
import 'package:t_learn/pages/kbc/bloc/kbc_bloc/kbc_bloc.dart';
import 'package:t_learn/pages/kbc/widgets/common/border_button.dart';
import 'package:t_learn/utils/constants.dart';
import '../../../utils/globals.dart';
import '../../../utils/utils.dart';
import '../widgets/common/backgroundws.dart';
import '../widgets/common/border_text.dart';

class KBCMainPage extends StatelessWidget {
  const KBCMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        const App().setNavigation(context, AppRoutes.home);
        return false;
      },
      child: Scaffold(
        body: BackgroundWS(
          child: BlocBuilder<KbcBloc,KbcState>(
              builder: (_,state){
                return MainBody(isLoading: state is KbcLoading);
              }))));
  }
}

class MainBody extends StatelessWidget {
  final bool isLoading;

  const MainBody({
    Key? key,
    required this.isLoading
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset('${appAssets}money_bag.png', width: 50,),
                  Utils.verticalDividerMedium,
                  Text(Globals.coins, style: kbcAmountStyle),
                  Utils.verticalDivider_30
                ],
            ),

            Stack(
              alignment: Alignment.center,
              children: [
                Lottie.asset("${appAssets}light_effect.json"),
                Column(
                  children: const [
                    BorderedText(text: "Trivia", strokeColor: secondaryColor,offset: 0,),
                    BorderedText(text: "Master", strokeColor: secondaryColor,offset: 0,),
                  ],
                )
              ],
            ),

            StylizedButton(
              child: const StylizedContainer(
                color: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 18),
                child: BorderedText(
                  text: "Play",
                  strokeColor: tcWhite,
                  fontSize: 24)),
              onPressed: ()=>const App().setNavigation(context, AppRoutes.kbc),
            )
          ]
        ),
        Visibility(
            visible: isLoading,
            child: Container(
              color: Colors.black54,
              child: Center(child: Lottie.asset('${appAssets}game_loading.json'))))
      ],
    );
  }
}

