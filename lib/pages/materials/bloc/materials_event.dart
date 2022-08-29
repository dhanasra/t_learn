part of 'materials_bloc.dart';

@immutable
abstract class MaterialsEvent {}

class GetMaterialsEvent extends MaterialsEvent {}

class GetInformationEvent extends MaterialsEvent {}

class GetMaterialsListEvent extends MaterialsEvent {}

class SaveMaterialsEvent extends MaterialsEvent {}

class DownloadMaterialsEvent extends MaterialsEvent {
  final NotesItem notesItem;

  DownloadMaterialsEvent({required this.notesItem});
}