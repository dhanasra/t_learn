import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_learn/pages/account/bloc/profile_bloc.dart';
import 'package:t_learn/pages/account/views/app_settings.dart';
import 'package:t_learn/pages/account/views/edit_profile.dart';
import 'package:t_learn/pages/account/views/exam_settings.dart';
import 'package:t_learn/pages/account/views/my_profile.dart';
import 'package:t_learn/pages/analysis/bloc/analysis_bloc.dart';
import 'package:t_learn/pages/analysis/views/analysis_chapter_page.dart';
import 'package:t_learn/pages/analysis/views/analysis_page.dart';
import 'package:t_learn/pages/analysis/views/analysis_single_page.dart';
import 'package:t_learn/pages/auth/bloc/exam/exam_bloc.dart';
import 'package:t_learn/pages/auth/views/details_page.dart';
import 'package:t_learn/pages/auth/views/exam_page.dart';
import 'package:t_learn/pages/auth/views/forgot_password_page.dart';
import 'package:t_learn/pages/auth/views/landing_page.dart';
import 'package:t_learn/pages/auth/views/login_page.dart';
import 'package:t_learn/pages/auth/views/setup_loading_page.dart';
import 'package:t_learn/pages/auth/views/signup_page.dart';
import 'package:t_learn/pages/chat/views/chat_page.dart';
import 'package:t_learn/pages/home/cubit/home_cubit.dart';
import 'package:t_learn/pages/home/views/home_page.dart';
import 'package:t_learn/pages/kbc/bloc/cubit/levels_cubit.dart';
import 'package:t_learn/pages/kbc/bloc/kbc_bloc/kbc_bloc.dart';
import 'package:t_learn/pages/kbc/views/kbc_levels_page.dart';
import 'package:t_learn/pages/kbc/views/kbc_main_page.dart';
import 'package:t_learn/pages/kbc/views/kbc_page.dart';
import 'package:t_learn/pages/materials/bloc/materials_bloc.dart';
import 'package:t_learn/pages/materials/views/materials_list_page.dart';
import 'package:t_learn/pages/materials/views/materials_viewer_page.dart';
import 'package:t_learn/pages/practice/bloc/practice_bloc.dart';
import 'package:t_learn/pages/practice/views/practice_main_page.dart';
import 'package:t_learn/pages/practice/views/practice_page.dart';
import 'package:t_learn/pages/quiz/bloc/quiz_bloc/quiz_bloc.dart';
import 'package:t_learn/pages/quiz/bloc/today_bloc/quiz_today_bloc.dart';
import 'package:t_learn/pages/quiz/views/quiz_info_page.dart';
import 'package:t_learn/pages/quiz/views/quiz_list_page.dart';
import 'package:t_learn/pages/quiz/views/quiz_main_page.dart';
import 'package:t_learn/pages/quiz/views/quiz_page.dart';
import 'package:t_learn/pages/quiz/views/quiz_result_page.dart';
import 'package:t_learn/pages/quiz/views/quiz_solutions_page.dart';
import 'package:t_learn/pages/quiz/views/quiz_today_page.dart';
import 'package:t_learn/pages/quiz/views/quiz_today_result.dart';
import 'package:t_learn/pages/quiz/views/quiz_topics_page.dart';
import 'package:t_learn/pages/splash/views/no_internet_page.dart';
import 'package:t_learn/pages/splash/views/splash_page.dart';
import 'package:t_learn/pages/subscription/bloc/subscription_bloc.dart';
import 'package:t_learn/pages/subscription/cubit/subscription_cubit.dart';
import 'package:t_learn/pages/subscription/views/subscription_page.dart';
import 'package:t_learn/pages/subscription/views/subscription_payment_success.dart';

import '../pages/auth/bloc/authentication_bloc.dart';
import '../pages/chat/blocs/chat_bloc/chat_bloc.dart';
import '../pages/chat/blocs/image_bloc/image_bloc.dart';
import '../pages/kbc/bloc/cubit/options_cubit.dart';
import '../pages/kbc/bloc/cubit/rewarded_cubit.dart';

class AppRoutes {

  static const String splash = 'splash';
  static const String noInternet = 'no_internet';

  //authentication
  static const String landing = 'landing';
  static const String signup = 'auth/signup';
  static const String login = 'auth/login';
  static const String name = 'auth/name';
  static const String exam = 'auth/exam';
  static const String forgotPassword = 'auth/forgot_password';
  static const String setupLoading = 'auth/setup_loading';

  //profile
  static const String appSettings = 'account/app_settings';
  static const String examSettings = 'account/exam_settings';
  static const String editProfile = 'account/profile/edit_profile';
  static const String myProfile = 'account/profile';

  //chat
  static const String chat = 'chat';

  //quiz
  static const String quiz = 'quiz';
  static const String quizToday = 'quiz/today';
  static const String quizInfo = 'qui/info';
  static const String quizChapters = 'quiz/chapters';
  static const String quizList = 'quiz/list';
  static const String quizGame = 'quiz/game';
  static const String quizResult = 'quiz/result';
  static const String quizTodayResult = 'quiz/today/result';
  static const String quizSolutions = 'quiz/solutions';

  //notes
  static const String notesList = 'notes/list';
  static const String notesViewer = 'notes/viewer';

  //home
  static const String home = 'home';

  //subscription
  static const String subscription = 'subscription';
  static const String subscriptionSuccess = 'subscription/success';

  //analysis
  static const String analysis = 'analysis';
  static const String analysisChapter = 'analysis/chapter';
  static const String analysisSingle = 'analysis/single';

  //practice
  static const String practiceMain = 'practice/main';
  static const String practiceList = 'practice/list';
  static const String practice = 'practice';

  //kbc
  static const String kbcMain = 'kbc/main';
  static const String kbcLevels = 'kbc/levels';
  static const String kbcLoading = 'kbc/loading';
  static const String kbc = 'kbc';


  Route getRoutes(RouteSettings routeSettings) {
    switch(routeSettings.name) {
      case kbcLevels: return MaterialPageRoute(
          settings: routeSettings, builder: (BuildContext context) => const KBCLevelsPage() );
      case kbc: return MaterialPageRoute(
          settings: routeSettings, builder: (BuildContext context) => const KBCPage() );
      case kbcMain: return MaterialPageRoute(
          settings: routeSettings, builder: (BuildContext context) => const KBCMainPage() );
      case practice: return MaterialPageRoute(
          settings: routeSettings, builder: (BuildContext context) => const PracticePage() );
      case practiceMain: return MaterialPageRoute(
          settings: routeSettings, builder: (BuildContext context) => const PracticeMainPage() );
      case analysis: return MaterialPageRoute(
          settings: routeSettings, builder: (BuildContext context) => const AnalysisPage() );
      case analysisChapter: return MaterialPageRoute(
          settings: routeSettings, builder: (BuildContext context) => const AnalysisChapterPage() );
      case analysisSingle: return MaterialPageRoute(
          settings: routeSettings, builder: (BuildContext context) => const AnalysisSinglePage() );
      case subscriptionSuccess: return MaterialPageRoute(
          settings: routeSettings, builder: (BuildContext context) => const SubscriptionPaymentSuccess() );
      case subscription: return MaterialPageRoute(
          settings: routeSettings, builder: (BuildContext context) => const SubscriptionPage() );
      case home: return MaterialPageRoute(
          settings: routeSettings, builder: (BuildContext context) => const HomePage() );
      case notesList: return MaterialPageRoute(
          settings: routeSettings, builder: (BuildContext context) => const MaterialsListPage() );
      case notesViewer: return MaterialPageRoute(
          settings: routeSettings, builder: (BuildContext context) => const MaterialsViewerPage() );
      case quizSolutions: return MaterialPageRoute(
        settings: routeSettings, builder: (BuildContext context) => const QuizSolutionsPage() );
      case quizTodayResult: return MaterialPageRoute(
          settings: routeSettings, builder: (BuildContext context) => const QuizTodayResult() );
      case quizResult: return MaterialPageRoute(
          settings: routeSettings, builder: (BuildContext context) => const QuizResultPage() );
      case quiz: return MaterialPageRoute(
          settings: routeSettings, builder: (BuildContext context) => const QuizMainPage() );
      case quizToday: return MaterialPageRoute(
          settings: routeSettings, builder: (BuildContext context) => const QuizTodayPage() );
      case quizInfo: return MaterialPageRoute(
          settings: routeSettings, builder: (BuildContext context) => const QuizInfoPage() );
      case quizGame: return MaterialPageRoute(
          settings: routeSettings, builder: (BuildContext context) => const QuizPage() );
      case quizChapters: return MaterialPageRoute(
          settings: routeSettings, builder: (BuildContext context) => const QuizTopicsPage() );
      case quizList: return MaterialPageRoute(
          settings: routeSettings, builder: (BuildContext context) => const QuizListPage() );
      case chat: return MaterialPageRoute(
          settings: routeSettings, builder: (BuildContext context) => const ChatPage() );
      case appSettings: return MaterialPageRoute(
          settings: routeSettings, builder: (BuildContext context) => const AppSettings() );
      case examSettings: return MaterialPageRoute(
          settings: routeSettings, builder: (BuildContext context) => const ExamSettings() );
      case editProfile: return MaterialPageRoute(
          settings: routeSettings, builder: (BuildContext context) => const EditProfile() );
      case myProfile: return MaterialPageRoute(
          settings: routeSettings, builder: (BuildContext context) => const MyProfile() );
      case setupLoading: return MaterialPageRoute(
          settings: routeSettings, builder: (BuildContext context) => const SetupLoadingPage() );
      case name: return MaterialPageRoute(
          settings: routeSettings, builder: (BuildContext context) => const DetailsPage() );
      case exam: return MaterialPageRoute(
          settings: routeSettings, builder: (BuildContext context) => const ExamPage() );
      case forgotPassword: return MaterialPageRoute(
          settings: routeSettings, builder: (BuildContext context) => const ForgotPasswordPage() );
      case login: return MaterialPageRoute(
          settings: routeSettings, builder: (BuildContext context) => const LoginPage() );
      case signup: return MaterialPageRoute(
          settings: routeSettings, builder: (BuildContext context) => const SignupPage() );
      case landing: return MaterialPageRoute(
          settings: routeSettings, builder: (BuildContext context) => const LandingPage() );
      case noInternet: return MaterialPageRoute(
          settings: routeSettings, builder: (BuildContext context) => const NoInternetPage() );
      case splash: return MaterialPageRoute(
          settings: routeSettings, builder: (BuildContext context) => const SplashPage() );
      default: return MaterialPageRoute(
          settings: routeSettings, builder: (BuildContext context) => Container() );
    }
  }

  getWidget(BuildContext context, String appRouteName){
    switch(appRouteName) {
      case kbcLevels: return BlocProvider(
          create: (_)=>LevelsCubit()..moveNext(), child: const KBCLevelsPage(),);
      case kbc: return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => OptionsCubit()),
            BlocProvider(create: (_) => RewardedCubit()),
            BlocProvider(create: (_) => KbcBloc())
          ],
          child: const KBCPage());
      case kbcMain: return BlocProvider(
          create: (_)=>KbcBloc()..add(GetReady()), child: const KBCMainPage());
      case analysisSingle: return BlocProvider(
          create: (_)=> AnalysisBloc(), child: const AnalysisSinglePage() );
      case practice: return BlocProvider(
          create: (_)=> PracticeBloc()..add(GetAllQuestions()), child: const PracticePage() );
      case practiceMain: return BlocProvider(
          create: (_)=> PracticeBloc()..add(GetSubjects()), child: const PracticeMainPage() );
      case analysis: return BlocProvider(
          create: (_)=> AnalysisBloc()..add(GetOverAllScores())..add(GetTestScores()), child: const AnalysisPage() );
      case analysisChapter: return BlocProvider(
          create: (_)=> AnalysisBloc(), child: const AnalysisChapterPage() );
      case subscriptionSuccess: return const SubscriptionPaymentSuccess();
      case subscription: return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_)=>SubscriptionBloc()..add(GetAllSubscriptions())),
            BlocProvider(create: (_)=>SubscriptionCubit())
          ],
          child: const SubscriptionPage() );
      case home: return BlocProvider(
          create: (_)=> HomeCubit(), child: const HomePage() );
      case notesList: return BlocProvider(
          create: (_)=> MaterialsBloc()..add(GetMaterialsListEvent()), child: const MaterialsListPage() );
      case notesViewer: return BlocProvider( create: (_)=> MaterialsBloc(), child: const MaterialsViewerPage() );
      case quizSolutions: return BlocProvider( create: (_)=> QuizBloc(), child: const QuizSolutionsPage() );
      case quizTodayResult: return BlocProvider(
          create: (_)=> QuizTodayBloc()..add(GetResult()), child: const QuizTodayResult() );
      case quizResult: return BlocProvider(
          create: (_)=> QuizBloc()..add(GetQuizResultEvent()), child: const QuizResultPage() );
      case quiz: return BlocProvider( create: (_)=> QuizBloc(), child: const QuizMainPage() );
      case quizToday: return BlocProvider(
          create: (_)=> QuizTodayBloc()..add(GetTodayQuizInfo()), child: const QuizTodayPage() );
      case quizChapters: return BlocProvider(
          create: (_)=> QuizBloc()..add(GetChaptersEvent()), child: const QuizTopicsPage() );
      case quizList: return BlocProvider(
          create: (_)=> QuizBloc()..add(GetTestListEvent()), child: const QuizListPage() );
      case quizGame: return MultiBlocProvider(
          providers: [
            BlocProvider( create: (_)=> QuizBloc()),
          ],
          child: const QuizPage());
      case quizInfo: return BlocProvider(
          create: (_)=> QuizBloc()..add(GetQuestionEvent()), child: const QuizInfoPage() );
      case chat: return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_)=>ChatBloc()..add(RequestMessageEvent())),
            BlocProvider(create: (_)=>ImageBloc())
          ],
          child: const ChatPage() );
      case appSettings: return BlocProvider( create: (_)=> AuthenticationBloc(), child: const AppSettings() );
      case examSettings: return BlocProvider( create: (_)=> AuthenticationBloc(), child: const ExamSettings() );
      case myProfile: return BlocProvider( create: (_)=> ProfileBloc()..add(GetProfile()), child: const MyProfile() );
      case editProfile: return MultiBlocProvider(
          providers: [
            BlocProvider( create: (_)=> ProfileBloc()..add(GetProfile())),
            BlocProvider(create: (_)=>ImageBloc())
          ],
          child: const EditProfile() );
      case setupLoading: return BlocProvider(
          create: (_)=> AuthenticationBloc()..add(SaveInLocalDB()), child: const SetupLoadingPage() );
      case exam: return BlocProvider(
          create: (_)=> ExamBloc()..add(GetAllExams()), child: const ExamPage() );
      case name: return BlocProvider( create: (_)=> AuthenticationBloc(), child: const DetailsPage() );
      case forgotPassword: return BlocProvider( create: (_)=> AuthenticationBloc(), child: const ForgotPasswordPage() );
      case login: return BlocProvider( create: (_)=> AuthenticationBloc(), child: const LoginPage() );
      case signup: return BlocProvider( create: (_)=> AuthenticationBloc(), child: const SignupPage() );
      case landing: return BlocProvider( create: (_)=> AuthenticationBloc(), child: const LandingPage() );
      case noInternet: return const NoInternetPage();
      case splash: return const SplashPage();
      default: return Container();
    }
  }

}