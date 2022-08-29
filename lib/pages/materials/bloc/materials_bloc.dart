
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:t_learn/pages/materials/model/notes.dart';
import 'package:t_learn/pages/materials/model/notes_item.dart';
import 'package:t_learn/pages/materials/view_models/material_view_model.dart';
import 'package:t_learn/utils/fb.dart';
import 'package:t_learn/utils/local_db.dart';
import 'package:url_launcher/url_launcher.dart';

part 'materials_event.dart';
part 'materials_state.dart';

class MaterialsBloc extends Bloc<MaterialsEvent, MaterialsState> {

  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  MaterialsBloc() : super(MaterialsInitial()) {
    on<GetMaterialsEvent>(onGetMaterials);
    on<GetMaterialsListEvent>(onGetMaterialsItemList);
    on<SaveMaterialsEvent>(onSaveMaterials);
    on<GetInformationEvent>(onGetInformation);
    on<DownloadMaterialsEvent>(onDownloadMaterial);
  }

  void onGetMaterials(GetMaterialsEvent event, Emitter emit) async {
    emit(MaterialsLoading());

    final examCode = await LocalDB.getExamCode();
    print(examCode);
    final notesData = await DB.getOrderedData("${FirestorePath.materials}-$examCode", "id");

    print(notesData);
    emit(MaterialsFetched(notes: Notes.getNotessList(notesData)));
  }

  void onGetInformation(GetInformationEvent event, Emitter emit) async {
    emit(InformationLoading());

    final examCode = await LocalDB.getExamCode();
    final notesData = await DB.getOrderedData("${FirestorePath.information}-$examCode", "id");
    emit(InformationFetched(notes: Notes.getNotessList(notesData)));
  }

  void onGetMaterialsItemList(GetMaterialsListEvent event, Emitter emit) async {
    emit(MaterialsLoading());
    var path = MaterialViewModel.selectedNotes!.link;
    Response response = await Dio().get(path);
    var notesData = NotesItem.getNotesItemsList(response.data);
    emit(MaterialsItemFetched(notesItem: notesData));
  }

  void onDownloadMaterial(DownloadMaterialsEvent event, Emitter emit) async {

    // launchUrl(Uri.parse(event.notesItem.link));
    emit(MaterialsDownloadingStart());
    if (await Permission.storage.request().isGranted) {
      _setPath(event.notesItem.link, emit);
      emit(MaterialDownloading(value: 1));
    }
  }

  void _setPath(String link, Emitter emit) async {
    // Directory? path = await getExternalStorageDirectory();
    // String localPath = '/storage/emulated/0/Download/';
    // final savedDir = Directory(localPath);
    // bool hasExisted = await savedDir.exists();
    // // print(path.path);
    // if (!hasExisted) {
    //   savedDir.create();
    // }
    // path = _localPath;

    var dir = await getExternalStorageDirectory();
    if(dir != null) {
      String savename = "banner.pdf";
      String savePath = dir.path + "/$savename";
      print(savePath);
      try {
        await Dio().download(
            link,
            savePath,
            onReceiveProgress: (received, total) {
              if (total != -1) {

              }
            });
        print("Image is saved to download folder.");
        emit(MaterialDownloaded());
      } on DioError catch (e) {
        print(e.message);
      }
    }
  }

  void onSaveMaterials(SaveMaterialsEvent event, Emitter emit) async {
    try{

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? savedString = prefs.getString(LocalDBKeys.saved);
      List<NotesItem> notesItem = [];
      if(savedString!=null) notesItem = NotesItem.decode(savedString);

      bool alreadySaved = notesItem.any((element) => element.id==MaterialViewModel.notesItem!.id);

      if(!alreadySaved){
        notesItem.add(MaterialViewModel.notesItem!);
        String encodeData = NotesItem.encode(notesItem);
        await prefs.setString(LocalDBKeys.saved, encodeData);
      }

      // await prefs.setString(LocalDBKeys.saved, "[]");

      emit(MaterialSaved());
    }catch(e){
      print(e);
    }
  }


}
