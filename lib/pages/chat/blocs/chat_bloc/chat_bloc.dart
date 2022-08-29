import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:meta/meta.dart';
import 'package:t_learn/pages/chat/model/message.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {

  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  ChatBloc() : super(ChatInitial()) {
    on<RequestMessageEvent>(onRequestMessages);
    on<MessageReceivedEvent>(onMessageReceived);
    on<SendMessageEvent>(onMessageSend);
    on<DeleteMessageEvent>(onDeleteMessage);
  }

  void onRequestMessages(RequestMessageEvent event, Emitter emit) async{
    emit(MessageReceivedLoading());
    final querySnapShotStream = fireStore.collection("group_chat").orderBy("dateTime",descending: true).snapshots();

    Stream queryStream = querySnapShotStream.map((event) =>  event.docs.map((e) {
      var docMap = e.data();
      docMap["contentId"] = e.id;
      return docMap;
    }).toList());

    queryStream.listen((messages) {
      add(MessageReceivedEvent(messages: Message.getMessageList(messages)));
    });
  }

  void onMessageReceived(MessageReceivedEvent event, Emitter emit){
    emit(MessageReceivedSuccess(messages: event.messages));
  }

  void onMessageSend(SendMessageEvent event, Emitter emit) async{
    emit(MessageReceivedLoading());

    String? contentImage;

    print("${event.contentImage} dd");

    if(event.contentImage!=null){
      contentImage = await uploadImage(event.contentImage!);
    }

    var message = {
      "userId": user?.uid,
      "userImage": user?.photoURL,
      "dateTime": DateTime.now().microsecondsSinceEpoch,
      "content": event.content,
      "contentImage": contentImage};
    await fireStore.collection("group_chat").add(message);
    emit(MessageSendSuccess());
  }

  Future<String> uploadImage(String path) async {
    Reference reference = FirebaseStorage.instance.ref().child(user!.uid).child("chat").child(path.split('/').last);
    await reference.putFile(File(path));
    return Future.value(await reference.getDownloadURL());
  }

  void onDeleteMessage(DeleteMessageEvent event, Emitter emit) async {
    fireStore.collection("group_chat").doc(event.contentId).delete();
  }
}
