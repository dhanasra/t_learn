import 'package:url_launcher/url_launcher.dart';

import '../../../utils/constants.dart';

class SplashViewModel {

  static late SplashViewModel _instance;
  factory SplashViewModel() {
    _instance = SplashViewModel._internal();
    return _instance;
  }
  SplashViewModel._internal();


  void setLocale(){

  }

}