part of 'saved_materials_bloc.dart';

@immutable
abstract class SavedMaterialsState {}

class SavedMaterialsInitial extends SavedMaterialsState {}

class SavedMaterialsLoading extends SavedMaterialsState {}

class SavedMaterialsFetched extends SavedMaterialsState {
  final List<NotesItem> notesItem;
  SavedMaterialsFetched({required this.notesItem});
}