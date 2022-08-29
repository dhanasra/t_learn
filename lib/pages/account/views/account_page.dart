import 'package:app_settings/app_settings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:t_learn/app/app.dart';
import 'package:t_learn/app/app_routes.dart';
import 'package:t_learn/pages/account/view_models/account_view_model.dart';
import 'package:t_learn/utils/constants.dart';
import 'package:t_learn/utils/globals.dart';
import 'package:t_learn/widgets/background.dart';
import 'package:t_learn/widgets/custom_sheet.dart';

import '../../../widgets/custom_image.dart';
import '../widgets/profile_option.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Background(
            isBackPressed: true,
            title: "Account",
            onBackPress: (){
              const App().closeApp();
            },
            child: const SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: MainBody(),
            )),
        onWillPop: ()async{
          const App().closeApp();
          return false;
        });
  }
}

class MainBody extends StatelessWidget {
  const MainBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final AccountViewModel viewModel = AccountViewModel();

    return Column(
      children: [
        CustomImage.decorated(width: 90, height: 90, isCircle: true, img: Globals.photo),
        const Divider(color: Colors.transparent),
        Text(Globals.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: primaryColor),),
        const Divider(color: Colors.transparent),
        ProfileOption(icon: FontAwesomeIcons.solidUser, option: "My Profile", onClick: ()=>const App().setNavigation(context, AppRoutes.myProfile)),
        ProfileOption(icon: Icons.diamond_rounded, option: "Upgrade to premium", onClick: ()=>const App().setNavigation(context, AppRoutes.subscription), isPrimary: true,),
        const Divider(),
        Align(alignment: Alignment.centerLeft ,child:
          Text("Settings", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.blueGrey.withOpacity(1)),).tr(),),
        const Divider(color: Colors.transparent,),
        ProfileOption(icon: Icons.app_settings_alt, option: "App Settings", onClick: ()=>const App().setNavigation(context, AppRoutes.appSettings)),
        ProfileOption(icon: Icons.edit, option: "Exam Settings", onClick: ()=>const App().setNavigation(context, AppRoutes.examSettings)),
        ProfileOption(icon: Icons.notifications, option: "Notification Settings", onClick: ()=>AppSettings.openNotificationSettings()),
        const Divider(),
        Align(alignment: Alignment.centerLeft ,child:
        Text("Feedback", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.blueGrey.withOpacity(1)),).tr(),),
        const Divider(color: Colors.transparent,),
        ProfileOption(icon: Icons.star, option: "Rate us", onClick: ()=>viewModel.openPlayStoreRateUs()),
        ProfileOption(icon: Icons.help_outline, option: "Contact TL Support", onClick: ()=>viewModel.contactSupport()),
        const Divider(height: 30,),
        ProfileOption(icon: Icons.arrow_circle_right_rounded, option: "Logout", onClick: ()=>CustomSheet.showLogout(context),),
      ],
    );
  }
}

