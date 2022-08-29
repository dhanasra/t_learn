import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:t_learn/app/app.dart';
import 'package:t_learn/app/app_routes.dart';
import 'package:t_learn/pages/kbc/bloc/cubit/levels_cubit.dart';
import 'package:t_learn/pages/kbc/views/kbc_view_model.dart';
import 'package:t_learn/pages/kbc/widgets/common/backgroundws.dart';
import 'package:t_learn/pages/kbc/widgets/common/border_text.dart';
import 'package:t_learn/pages/kbc/widgets/common/kbc_option.dart';
import 'package:t_learn/utils/constants.dart';
import 'package:t_learn/utils/utils.dart';

class KBCLevelsPage extends StatelessWidget {
  const KBCLevelsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: BlocListener<LevelsCubit, String>(
            listener: (_,state) => state=="goBack"
                ?  const App().setNavigation(context, AppRoutes.kbc)
                : state=="goBackHome"
                ? const App().setNavigation(context, AppRoutes.kbcMain)
                : null,
            child: BlocBuilder<LevelsCubit, String>(
              builder: (_,state){
                return BackgroundWS(
                    child: MainBody(
                        currentLevel: int.tryParse(state.toString())!=null
                            ? int.parse(state.toString())
                            : KBCViewModel.stage
                    )
                );
              },
            ),
          ),
        ));
  }
}

class MainBody extends StatelessWidget {
  final int currentLevel;
  const MainBody({
    Key? key,
    required this.currentLevel
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        Visibility(
            visible: currentLevel!=15,
            replacement: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const BorderedText(text: "You Won!", strokeColor: Colors.white,offset: 0,),
                Utils.dividerExtraLarge,
                Image.asset("${appAssets}money_bag.png", width: 54,),
                Utils.dividerLarge,
                const Text("1000 coins", style: kbcAmountStyle),
              ],
            ),
            child: ListView(
              padding: const EdgeInsets.only(top: 60),
              children: [
                HexagonContainer(
                    background: currentLevel==14 ? appGradient4 : appGradient3,
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 30),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(FontAwesomeIcons.trophy, size: 18, color: Colors.red,),
                        Expanded(
                            child: Text("\u20B9 1000", style: levelHeaderTextStyle, textAlign: TextAlign.center, )),
                        Icon(FontAwesomeIcons.trophy, size: 18, color: Colors.red)
                      ],
                    )),

                Utils.divider_50,

                ...List.generate(14, (index) =>
                    HexagonContainer(
                        background: index==currentLevel ? rgSuccess : rg,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${index+1}", style: levelTextStyle),
                            Text("\u20B9 ${kbcCoins[index]}", style: levelTextStyle)
                          ],
                        ))).reversed.toList(),
              ],
            ),
        ),

        Container(
          child: Lottie.asset('${appAssets}confetti.json', repeat: false),
        )
      ],
    );
  }
}

