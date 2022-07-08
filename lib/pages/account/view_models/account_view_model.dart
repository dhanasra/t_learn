import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountViewModel {

  static late AccountViewModel _instance;
  factory AccountViewModel() {
    _instance = AccountViewModel._internal();
    return _instance;
  }
  AccountViewModel._internal() {
    _init();
  }

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneNumberController;
  late TextEditingController cityController;

  static String gender = "m";


  void _init(){

    emailController = TextEditingController();
    nameController = TextEditingController();
    phoneNumberController = TextEditingController();
    cityController = TextEditingController();

  }

  void clearInputs(){
    emailController.text = "";
    cityController.text = "";
    phoneNumberController.text = "";
    nameController.text = "";
  }

  contactSupport(){
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'contact@splitit.com',
      query: encodeQueryParameters(<String, String>{
        'subject': 'Split It User Support'
      }),
    );
    launchUrl(emailLaunchUri);
  }

  openPlayStoreRateUs(){
    final Uri emailLaunchUri = Uri.parse('https://play.google.com/store/apps/details?id=com.whatsapp.w4b',);
    launchUrl(emailLaunchUri);
  }

}