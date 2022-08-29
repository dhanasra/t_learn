import 'package:equatable/equatable.dart';

class Question extends Equatable{

  final int id;
  final String questionId;
  final String question;
  final String? questionImg;
  final String option1;
  final String option2;
  final String option3;
  final String option4;
  final String answer;
  final String questionType;
  final String? explanation;
  final String? explanationImg;
  final String? subject;
  final String? exam;
  final String? questionPaper;

  const Question({
    required this.id,
    required this.questionId,
    required this.question,
    required this.questionImg,
    required this.option1,
    required this.option2,
    required this.option3,
    required this.option4,
    required this.answer,
    required this.questionPaper,
    required this.questionType,
    required this.exam,
    required this.explanation,
    required this.explanationImg,
    required this.subject
  });


  static List<Question> getQuestionList(List<dynamic> data){
    return data.map((e) => Question.fromJson(e)).toList();
  }

  factory Question.fromJson(Map<String,dynamic> data) {

    final id = data['id'];
    final questionId = data['questionId'];
    final question = data['question'];
    final questionImg = data['questionImg'];
    final option1 = data['option1'];
    final option2 = data['option2'];
    final option3 = data['option3'];
    final option4 = data['option4'];
    final answer = data['answer'];
    final questionPaper = data['questionPaper'];
    final questionType = data['questionType'];
    final exam = data['exam'];
    final explanation = data['explanation'];
    final explanationImg = data['explanationImg'];
    final subject = data['subject'];

    return Question(
        id: id,
        questionId: questionId,
        question: question,
        questionImg: questionImg,
        option1: option1,
        option2: option2,
        option3: option3,
        option4: option4,
        answer: answer,
        questionPaper: questionPaper,
        questionType: questionType,
        exam: exam,
        explanation: explanation,
        explanationImg: explanationImg,
        subject: subject
    );
  }



  @override
  List<Object?> get props => [
    question,
    questionImg,
    option1,
    option2,
    option3,
    option4,
    answer
  ];

}