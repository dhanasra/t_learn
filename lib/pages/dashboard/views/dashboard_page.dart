
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:t_learn/app/app.dart';
import 'package:t_learn/app/app_routes.dart';
import 'package:t_learn/pages/dashboard/views/DashboardViewModel.dart';
import 'package:t_learn/pages/home/widgets/info_card.dart';
import 'package:t_learn/pages/home/widgets/pro_card.dart';
import 'package:t_learn/utils/constants.dart';
import 'package:t_learn/utils/globals.dart';
import 'package:t_learn/utils/utils.dart';
import 'package:t_learn/widgets/background.dart';

import '../../../utils/widgets/constants.dart';
import '../../../widgets/custom_image.dart';
import '../../../widgets/loading.dart';
import '../../materials/bloc/materials_bloc.dart';
import '../../materials/model/notes.dart';
import '../../materials/widgets/materials_main_item.dart';
import '../../quiz/model/exam.dart';
import '../../quiz/views/quiz_main_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Background(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.asset("${appAssets}app_logo.png", height: 30,),
                  Utils.verticalDividerSmall,
                  Text(Globals.exam, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Utils.darkenColor(Colors.yellow)),),
                  Text(" padi", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Utils.darkenColor(Colors.lightGreen)),).tr()
                ],
              ),
              actions: [
                IconButton(
                  icon: const Icon(FontAwesomeIcons.solidComments, size: 26),
                  onPressed: ()=>const App().setNavigation(context, AppRoutes.chat),
                  splashRadius: 20,
                ),
              ],
              centerTitle: false,
            ),
            child: BlocProvider(
                create: (_)=>MaterialsBloc()..add(GetMaterialsEvent())..add(GetInformationEvent()),
                child: const MainBody()
            )
        ),
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

    final viewModel = DashboardViewModel();

    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      children: [
        Utils.dividerSmall,

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              CustomImage.decorated(width: 60, height: 60, isCircle: true, img: Globals.photo),
              Utils.verticalDividerLarge,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hey ${Globals.name} ,", style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),),
                  Utils.dividerSmall,
                  const Text("Let's start preparation !").tr(),
                ],
              ),
            ],
          ),
        ),

        Utils.divider_35,

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Text("Subject Wise Materials",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)).tr(),
        ),

        Utils.dividerSmall,

        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text("100+ materials",
                style: TextStyle(color: Theme.of(context).canvasColor.withOpacity(0.6), fontWeight: FontWeight.w600, fontSize: 12)).tr()
        ),

        Utils.divider,

        BlocBuilder<MaterialsBloc,MaterialsState>(
            buildWhen: (_,state)=>state is MaterialsLoading || state is MaterialsFetched,
            builder: (_,state){
              if(state is MaterialsLoading){
                return const MaterialsListGrid(isLoading: true);
              }else if(state is MaterialsFetched){
                return MaterialsListGrid(isLoading: false, notes: state.notes,);
              }else{
                return const SizedBox();
              }
            }),

        Utils.divider,

        if(!Globals.isPrime)
        const Padding(
          padding: EdgeInsets.all(10),
          child: ProCard(),
        ),

        if(!Globals.isPrime)
        Utils.divider,

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Text("Exam information",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)).tr(),
        ),

        Utils.dividerSmall,

        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text("Plan with correct information",
                style: TextStyle(color: Theme.of(context).canvasColor.withOpacity(0.6), fontWeight: FontWeight.w600, fontSize: 12)).tr()
        ),

        Utils.divider,

        BlocBuilder<MaterialsBloc,MaterialsState>(
            buildWhen: (_,state)=>state is InformationLoading || state is InformationFetched,
            builder: (_,state){
              if(state is InformationLoading){
                return const MaterialsListGrid(isLoading: true);
              }else if(state is InformationFetched){
                return MaterialsListGrid(isLoading: false, notes: state.notes,);
              }else{
                return const SizedBox();
              }
            }),

        Divider(height: 60,thickness: 8,color: Theme.of(context).shadowColor,),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Text("Reach us on",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)).tr(),
        ),

        Utils.dividerLarge,

        InfoCard(icon: "telegram.png", option: "Join us on telegram", onClick: ()=>viewModel.openSocialMediaPlatform(telegramLink)),
        Utils.dividerSmall,
        InfoCard(icon: "instagram.png", option: "Follow us on instagram", onClick: ()=>viewModel.openSocialMediaPlatform(instaLink)),
        Utils.dividerSmall,
        InfoCard(icon: "gmail.png", option: "Send your queries", onClick: ()=>viewModel.openMail()),
      ],
    );
  }
}

class MaterialsListGrid extends StatelessWidget {
  final bool isLoading;
  final List<Notes>? notes;

  const MaterialsListGrid({
    Key? key,
    required this.isLoading,
    this.notes
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, crossAxisSpacing: 0, mainAxisSpacing: 0),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: isLoading ? 3 : notes!.length,
          itemBuilder: (_,index){
            return isLoading
                ? const Padding(padding: EdgeInsets.all(10), child: Loading(type: shimmer_1))
                : MaterialsMainItem(notes: notes![index],);
          }
      ),
    );
  }
}

