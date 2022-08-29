import 'package:equatable/equatable.dart';

class Course extends Equatable{

  final String id;
  final String code;
  final String name;
  final String? subName;
  final String lang;
  final String icon;

  const Course({
    required this.id,
    required this.name,
    this.subName,
    required this.code,
    required this.icon,
    required this.lang
  });

  static List<Course> getCourseList(List<dynamic> data){
    return data.map((e) => Course.fromJson(e)).toList();
  }

  factory Course.fromJson(Map<String,dynamic> data) {

    final id = data['id'];
    final name = data['name'];
    final subName = data['subName'];
    final code = data['code'];
    final lang = data['lang'];
    final icon = data['icon'];

    return Course(
        id: id,
        name: name,
        code: code,
        lang: lang,
        icon: icon,
        subName: subName
    );
  }

  @override
  List<Object?> get props => [];
}