import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Message extends Equatable{

  final String userId;
  final String? userImage;
  final int dateTime;
  final String content;
  final String contentImage;
  final bool isMe;

  const Message({
    required this.userId,
    required this.userImage,
    required this.dateTime,
    required this.content,
    required this.isMe,
    required this.contentImage
  });


  static List<Message> getMessageList(List<Map<String,dynamic>> data){
    return data.map((e) => Message.fromJson(e)).toList();
  }

  factory Message.fromJson(Map<String,dynamic> data) {

    final userId = data['userId'];
    final userImage = data['userImage'];
    final dateTime = data['dateTime'];
    final content = data['content'];
    final contentImage = data['contentImage'];

    final User user = FirebaseAuth.instance.currentUser!;

    return Message(
        userId: userId,
        userImage: userImage,
        dateTime: dateTime,
        content: content,
        contentImage: contentImage,
        isMe: user.uid == userId
    );
  }



  @override
  List<Object?> get props => [
    userId,
    userImage,
    dateTime,
    content,
    contentImage
  ];

}