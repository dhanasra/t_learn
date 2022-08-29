import 'package:equatable/equatable.dart';

class Notes extends Equatable{

  final int id;
  final String name;
  final String size;
  final String icon;
  final String link;

  const Notes({
    required this.id,
    required this.name,
    required this.size,
    required this.icon,
    required this.link
  });

  static List<Notes> getNotessList(List<dynamic> data){
    return data.map((e) => Notes.fromJson(e)).toList();
  }

  factory Notes.fromJson(Map<String,dynamic> data) {

    final id = data['id'];
    final name = data['name'];
    final size = data['size'];
    final icon = data['icon'];
    final link = data['link'];

    return Notes(
        id: id,
        name: name,
        size: size,
        icon: icon,
        link: link
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    size,
    icon,
    link
  ];
}