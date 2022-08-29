
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../materials/model/notes_item.dart';

part 'saved_materials_event.dart';
part 'saved_materials_state.dart';

class SavedMaterialsBloc extends Bloc<SavedMaterialsEvent, SavedMaterialsState> {

  SavedMaterialsBloc() : super(SavedMaterialsInitial()) {
    on<GetSavedMaterials>(onGetSavedMaterials);
  }

  void onGetSavedMaterials(GetSavedMaterials event, Emitter emit) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String? savedString = preferences.getString("saved");

    if(savedString!=null){
      List<NotesItem> notesItem = NotesItem.decode(savedString);
      emit(SavedMaterialsFetched(notesItem: notesItem));
    }else{
      emit(SavedMaterialsFetched(notesItem: const []));
    }
  }
}
