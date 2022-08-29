import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_learn/pages/saved/bloc/saved_materials_bloc.dart';
import 'package:t_learn/pages/saved/widgets/empty_widget.dart';
import 'package:t_learn/widgets/background.dart';

import '../../../app/app.dart';
import '../../materials/views/materials_list_page.dart';

class SavedMaterialsPage extends StatelessWidget {
  const SavedMaterialsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Background(
            isBackPressed: true,
            title: "Saved Materials",
            onBackPress: (){
              const App().closeApp();
            },
            child: BlocProvider(
              create: (_)=>SavedMaterialsBloc()..add(GetSavedMaterials()),
              child: const MainBody(),
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
    return BlocBuilder<SavedMaterialsBloc,SavedMaterialsState>(
        builder: (_,state){
          if(state is SavedMaterialsLoading){
            return const MaterialsListBuilder(isLoading: true,);
          }else if(state is SavedMaterialsFetched){
            return state.notesItem.isNotEmpty
                ? MaterialsListBuilder(isLoading: false, notesItem: state.notesItem,)
                : const EmptyWidget();
          }else{
            return const SizedBox();
          }
        });
  }
}

