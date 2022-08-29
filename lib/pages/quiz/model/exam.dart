import 'package:equatable/equatable.dart';

class Exam extends Equatable{

  final int id;
  final String name;
  final String noOfTest;
  final String icon;
  final String link;

  const Exam({
    required this.id,
    required this.name,
    required this.noOfTest,
    required this.icon,
    required this.link
  });

  static List<Exam> getExamsList(List<dynamic> data){
    return data.map((e) => Exam.fromJson(e)).toList();
  }

  factory Exam.fromJson(Map<String,dynamic> data) {

    final id = data['id'];
    final name = data['name'];
    final noOfTest = data['noOfTest'];
    final icon = data['icon'];
    final link = data['link'];

    return Exam(
        id: id,
        name: name,
        noOfTest: noOfTest,
        icon: icon,
        link: link
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    noOfTest,
    icon,
    link
  ];
}