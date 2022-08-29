import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_learn/pages/materials/model/notes_item.dart';
import 'package:t_learn/pages/materials/widgets/materials_list_item.dart';
import 'package:t_learn/utils/widgets/constants.dart';
import 'package:t_learn/widgets/background.dart';
import 'package:t_learn/widgets/loading.dart';

import '../bloc/materials_bloc.dart';

class MaterialsListPage extends StatelessWidget {
  const MaterialsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Background(
        isBackPressed: true,
        child: MainBody());
  }
}


class MainBody extends StatelessWidget {
  const MainBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MaterialsBloc,MaterialsState>(
        builder: (_,state){
          if(state is MaterialsLoading){
            return const MaterialsListBuilder(isLoading: true,);
          }else if(state is MaterialsItemFetched){
            return MaterialsListBuilder(isLoading: false, notesItem: state.notesItem,);
          }else{
            return const SizedBox();
          }
        });
  }
}

class MaterialsListBuilder extends StatelessWidget {
  final bool isLoading;
  final List<NotesItem>? notesItem;
  const MaterialsListBuilder({Key? key, required this.isLoading, this.notesItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: isLoading ? 2 : notesItem!.length,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        itemBuilder: (_,index)=> isLoading
            ? Container(
              padding: const EdgeInsets.all(10),
              child: const Loading(type: shimmer_2))
              : MaterialsListItem(notesItem: notesItem![index],));
  }
}


