
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:t_learn/pages/quiz/view_models/quiz_view_model.dart';
import 'package:t_learn/pages/quiz/widgets/header_widget.dart';
import 'package:t_learn/pages/quiz/widgets/page_indicator_item.dart';
import 'package:t_learn/pages/quiz/widgets/question_item.dart';
import 'package:t_learn/utils/utils.dart';
import 'package:t_learn/widgets/admob.dart';
import 'package:t_learn/widgets/background.dart';

import '../../../app/app.dart';
import '../../../app/app_routes.dart';
import '../../../utils/constants.dart';
import '../bloc/quiz_bloc/quiz_bloc.dart';

final BannerAd myBanner = BannerAd(
  adUnitId: Admob.bannerId1,
  size: AdSize.banner,
  request: const AdRequest(),
  listener: const BannerAdListener(),
);

const AdSize adSize = AdSize(height: 50, width: 300);

InterstitialAd? _interstitialAd;
int _numInterstitialLoadAttempts = 0;
const int maxFailedLoadAttempts = 3;

class QuizPage extends StatelessWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    myBanner.load();
    _createInterstitialAd();

    return WillPopScope(
        child: Background(
          child: MainBody(),
        ),
        onWillPop: ()async{
          showQuitBottomSheet(context);
          return false;
        });
  }

  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: Admob.interstitialId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
            _interstitialAd!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
              _createInterstitialAd();
            }
          },
        ));
  }

  void showQuitBottomSheet(BuildContext context){
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(
            top: Radius.circular(25)),),
        backgroundColor: Theme.of(context).cardColor, context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Quit", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                Utils.divider_50,
                const Text("Do you want to quit your test?", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),),
                Utils.dividerExtraLarge,
                Row(
                  children: [
                    Expanded(
                        child: GestureDetector(
                          onTap: ()async{
                            await myBanner.dispose().then((value) {
                              _interstitialAd?.dispose();
                              const App().setNavigation(context, AppRoutes.home);
                            });
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Utils.darkenColor(primaryColor),
                                  borderRadius: BorderRadius.circular(4)
                              ),
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                              child: const Text( 'Yes', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),).tr()
                          ),
                        )
                    ),
                    const SizedBox(width: 20,),
                    Expanded(
                        child: GestureDetector(
                          onTap: ()=>const App().setBackNavigation(context),
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: Utils.darkenColor(primaryColor))
                              ),
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                              child: Text( 'No', style: TextStyle(color: Utils.darkenColor(primaryColor), fontWeight: FontWeight.w500),).tr()
                          ),
                        )
                    )
                  ],
                )
              ],
            ),
          );
        });
  }
}

class MainBody extends StatelessWidget {

  MainBody({Key? key}) : super(key: key);

  final ScrollController scrollController = ScrollController();
  final AdWidget adWidget = AdWidget(ad: myBanner);

  @override
  Widget build(BuildContext context) {

    PageController controller = PageController();

    return Column(
      children: [

        HeaderWidget(onSubmitted: () async{
          await myBanner.dispose().then((value){
            _showInterstitialAd(context);
          });
        },),

        Container(
          alignment: Alignment.center,
          width: myBanner.size.width.toDouble(),
          height: myBanner.size.height.toDouble(),
          child: adWidget,
        ),

        Utils.divider,

        Expanded(
            child: PageView.builder(
                itemCount: QuizViewModel.questions.length,
                controller: controller,
                onPageChanged: (index){
                  QuizViewModel.currentQuestionIndex = index+1;
                  BlocProvider.of<QuizBloc>(context).add(SwitchQuestionEvent(index: index));
                  _animateToIndex(context, index+1);
                },
                itemBuilder: (_,index){
                  return QuestionItem( question: QuizViewModel.questions[index] );
                })
        ),

        SizedBox(
          height: 60,
          child: ListView.builder(
              itemCount: QuizViewModel.questions.length,
              scrollDirection: Axis.horizontal,
              controller: scrollController,
              itemBuilder: (_,index){
                return PageIndicatorItem(
                    index: index,
                    onPressed: (){
                      QuizViewModel.currentQuestionIndex = index+1;
                      BlocProvider.of<QuizBloc>(context).add(SwitchQuestionEvent(index: index));
                      controller.jumpToPage(index);
                      _animateToIndex(context, index+1);
                    },
                    isActive: false
                );
              }
          ),
        )
      ],
    );
  }

  void _animateToIndex(BuildContext context, int index) {
    double width = 60.0;
    double screenWidth = MediaQuery.of(context).size.width;
    scrollController.animateTo(
      (index * width)-(screenWidth/2+width/2),
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }


  void _showInterstitialAd(BuildContext context) {

    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      if(QuizViewModel.type=="today"){
        const App().setNavigation(context, AppRoutes.quizTodayResult);
      }else{
        const App().setNavigation(context, AppRoutes.quizResult);
      }
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        if(QuizViewModel.type=="today"){
          const App().setNavigation(context, AppRoutes.quizTodayResult);
        }else{
          const App().setNavigation(context, AppRoutes.quizResult);
        }
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        if(QuizViewModel.type=="today"){
          const App().setNavigation(context, AppRoutes.quizTodayResult);
        }else{
          const App().setNavigation(context, AppRoutes.quizResult);
        }
        _createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }


  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: Admob.interstitialId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
            _interstitialAd!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
              _createInterstitialAd();
            }
          },
        ));
  }
}

