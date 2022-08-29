import 'package:equatable/equatable.dart';

class Test extends Equatable{

  final int id;
  final String name;
  final String subTag;
  final String noOfQuestions;
  final String marks;
  final String duration;
  final String icon;
  final String link;

  const Test({
    required this.id,
    required this.name,
    required this.subTag,
    required this.noOfQuestions,
    required this.marks,
    required this.duration,
    required this.link,
    required this.icon
  });

  static List<Test> getTestsList(List<dynamic> data){
    return data.map((e) => Test.fromJson(e)).toList();
  }

  factory Test.fromJson(Map<String,dynamic> data) {

    final id = data['id'];
    final name = data['name'];
    final subTag = data['subTag'];
    final noOfQuestions = data['noOfQuestions'];
    final marks = data['marks'];
    final duration = data['duration'];
    final link = data['link'];
    final icon = data['icon'];

    return Test(
        id: id,
        name: name,
        subTag: subTag,
        noOfQuestions: noOfQuestions,
        marks: marks,
        duration: duration,
        link: link,
        icon: icon
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    subTag,
    noOfQuestions,
    link,
    marks,
    duration,
    link
  ];
}