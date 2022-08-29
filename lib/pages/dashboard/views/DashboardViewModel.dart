import 'package:url_launcher/url_launcher.dart';

import '../../../utils/constants.dart';

class DashboardViewModel {

  static late DashboardViewModel _instance;
  factory DashboardViewModel() {
    _instance = DashboardViewModel._internal();
    return _instance;
  }
  DashboardViewModel._internal();

  openSocialMediaPlatform(String link){
    launchUrl(Uri.parse(link));
  }

  openMail(){
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: mailto,
      query: encodeQueryParameters(<String, String>{
        'subject': 'Padi User Support'
      }),
    );
    launchUrl(emailLaunchUri);
  }

}