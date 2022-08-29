import 'package:t_learn/pages/materials/model/notes_item.dart';

import '../model/notes.dart';

class MaterialViewModel {

  static late MaterialViewModel _instance;

  factory MaterialViewModel() {
    _instance = MaterialViewModel._internal();
    return _instance;
  }

  MaterialViewModel._internal() {
    _init();
  }

  static Notes? selectedNotes;
  static NotesItem? notesItem;

  static int downloadingValue = 0;

  _init(){

  }

}