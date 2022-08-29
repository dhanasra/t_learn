part of 'materials_bloc.dart';

@immutable
abstract class MaterialsState {}

class MaterialsInitial extends MaterialsState {}

class MaterialsLoading extends MaterialsState {}

class InformationLoading extends MaterialsState {}

class MaterialsFetched extends MaterialsState {
  final List<Notes> notes;
  MaterialsFetched({required this.notes});
}

class InformationFetched extends MaterialsState {
  final List<Notes> notes;
  InformationFetched({required this.notes});
}

class MaterialsItemFetched extends MaterialsState {
  final List<NotesItem> notesItem;
  MaterialsItemFetched({required this.notesItem});
}

class MaterialSaved extends MaterialsState {}

class MaterialsDownloadingStart extends MaterialsState {}

class MaterialDownloading extends MaterialsState {
  final int value;
  MaterialDownloading({required this.value});
}

class MaterialDownloaded extends MaterialsState {}