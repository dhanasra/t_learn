import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:t_learn/pages/kbc/bloc/cubit/options_cubit.dart';
import 'package:t_learn/pages/kbc/bloc/cubit/rewarded_cubit.dart';
import 'package:t_learn/pages/kbc/bloc/kbc_bloc/kbc_bloc.dart';
import 'package:t_learn/pages/kbc/views/kbc_view_model.dart';
import 'package:t_learn/pages/kbc/widgets/dialogues/leave_kbc.dart';
import 'package:t_learn/pages/kbc/widgets/dialogues/wrong_answer.dart';
import 'package:t_learn/pages/kbc/widgets/common/kbc_option.dart';
import 'package:t_learn/pages/kbc/widgets/question_item.dart';
import 'package:t_learn/pages/kbc/widgets/top_bar.dart';
import 'package:t_learn/utils/constants.dart';
import 'package:t_learn/utils/utils.dart';
import 'package:t_learn/widgets/admob.dart';
import '../../../app/app.dart';
import '../../../app/app_routes.dart';
import '../widgets/common/backgroundws.dart';
import '../widgets/life_lines.dart';

RewardedAd? _rewardedAd;
int _numRewardedLoadAttempts = 0;
const int maxFailedLoadAttempts = 3;

final BannerAd myBanner = BannerAd(
  adUnitId: Admob.bannerId4,
  size: AdSize.banner,
  request: const AdRequest(),
  listener: const BannerAdListener(),
);

class KBCPage extends StatelessWidget {
  const KBCPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    myBanner.load();
    _createRewardedAd();

    return WillPopScope(
        onWillPop: () async {
          context.read<KbcBloc>().add(StopTimer());
          KBCViewModel.reset();
          if(_rewardedAd!=null){
            await myBanner.dispose();
            await _rewardedAd?.dispose().then((value) =>
                const App().setNavigation(context, AppRoutes.kbcMain));
          }else{
            const App().setNavigation(context, AppRoutes.kbcMain);
          }
          return false;
        },
        child: Scaffold(
          body: BackgroundWS(
              gradient: appGradient2,
              child: MultiBlocListener(
                listeners: [
                  BlocListener<OptionsCubit, String>(
                      listener: (_,state){
                        if(state =="wrong"){
                          Future.delayed(
                              const Duration(milliseconds: 500),
                                  ()=>showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (_)=> WrongAnswer(
                                        pContext: context,)));
                        }
                      }),
                  BlocListener<RewardedCubit, String>(
                      listener: (_,state){
                        if(state=="showAd"){
                          _showRewardedAd(context);
                        }
                      }),
                  BlocListener<KbcBloc, KbcState>(
                      listenWhen: (_,state)=>state is KbcFinish,
                      listener: (_,state){
                        if(state is KbcFinish){
                          const App().setNavigation(context, AppRoutes.kbcMain);
                        }
                      })
                ],
                child: MainBody(),
              )
          ),
        ));
  }


  void _createRewardedAd() {
    RewardedAd.load(
        adUnitId: Admob.rewardedId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            _rewardedAd = ad;
            _numRewardedLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            _rewardedAd = null;
            _numRewardedLoadAttempts += 1;
            if (_numRewardedLoadAttempts < maxFailedLoadAttempts) {
              _createRewardedAd();
            }
          },
        ));
  }

  void _showRewardedAd(BuildContext context) {
    if (_rewardedAd == null) {
      return;
    }
    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad){},
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        ad.dispose();
        _createRewardedAd();
        KBCViewModel.reset();
        Future.delayed(
            const Duration(seconds: 1), ()=>const App().setNavigation(context, AppRoutes.kbcMain)
        );
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        ad.dispose();
        _createRewardedAd();
        KBCViewModel.reset();
        Future.delayed(
            const Duration(seconds: 1), ()=>const App().setNavigation(context, AppRoutes.kbcMain)
        );
      },
    );

    _rewardedAd!.setImmersiveMode(true);
    _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
          const App().setBackNavigation(context);
          KBCViewModel.selectedIndex=KBCViewModel.cQuestion.answer;
          context.read<OptionsCubit>().correct();
          KBCViewModel.questionsIndex++;
          Future.delayed(
              const Duration(seconds: 1), ()=>const App().setNavigation(context, AppRoutes.kbcLevels)
          );
        });
    _rewardedAd = null;
  }

}

class MainBody extends StatelessWidget {
  MainBody({
    Key? key,
  }) : super(key: key);

  final AdWidget adWidget = AdWidget(ad: myBanner);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          width: myBanner.size.width.toDouble(),
          height: myBanner.size.height.toDouble(),
          child: adWidget,
        ),
        TopBar(
          onBack: ()=>showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_)=> LeaveKBC(
                onLeaveClick: ()=> context.read<KbcBloc>().add(LeaveKbc()),
              )),
        ),
        Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 0),
              children: [
                QuestionItem(
                  question: KBCViewModel.cQuestion.question,
                  amount: KBCViewModel.amount,
                ),
                Utils.divider_35,
                Option(
                  option: KBCViewModel.cQuestion.option1,
                  optionIndex: "A"
                ),
                Option(
                  option: KBCViewModel.cQuestion.option2,
                  optionIndex: "B"),
                Option(
                  option: KBCViewModel.cQuestion.option3,
                  optionIndex: "C"),
                Option(
                  option: KBCViewModel.cQuestion.option4,
                  optionIndex: "D"),
              ],
            )
        ),
        LifeLines(
          on5050Click: ()=>context.read<OptionsCubit>().lifeLine5050(),
          onChangeClick: (){
            context.read<KbcBloc>().add(StopTimer());
            KBCViewModel.isLifeLine1Enable = false;
            KBCViewModel.cQuestion = KBCViewModel.questions[++KBCViewModel.questionsIndex];
            const App().setNavigation(context, AppRoutes.kbc);
          },
          onSkipClick: (){
            context.read<KbcBloc>().add(StopTimer());
            KBCViewModel.selectedIndex=KBCViewModel.cQuestion.answer;
            context.read<OptionsCubit>().correct();
            KBCViewModel.questionsIndex++;
            KBCViewModel.isLifeLine3Enable = false;
            Future.delayed(
                const Duration(seconds: 1), ()=>const App().setNavigation(context, AppRoutes.kbcLevels)
            );
          },
        ),
      ],
    );
  }
}

