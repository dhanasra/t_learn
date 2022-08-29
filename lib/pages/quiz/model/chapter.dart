import 'package:equatable/equatable.dart';

class Chapter extends Equatable{

  final int id;
  final String name;
  final String noOfQuestions;
  final String link;
  final bool isPrime;

  const Chapter({
    required this.id,
    required this.name,
    required this.noOfQuestions,
    required this.link,
    required this.isPrime
  });

  static List<Chapter> getChaptersList(List<dynamic> data){
    return data.map((e) => Chapter.fromJson(e)).toList();
  }

  factory Chapter.fromJson(Map<String,dynamic> data) {

    final id = data['id'];
    final name = data['name'];
    final noOfQuestions = data['noOfQuestions'];
    final link = data['link'];
    final isPrime = data['isPrime'];

    return Chapter(
        id: id,
        name: name,
        noOfQuestions: noOfQuestions,
        link: link,
        isPrime: isPrime
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    noOfQuestions,
    link
  ];
}