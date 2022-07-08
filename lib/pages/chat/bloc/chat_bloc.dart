import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  }

  void onRequestMessages(RequestMessageEvent event, Emitter emit) async{
    emit(MessageReceivedLoading());
    final querySnapShotStream = fireStore.collection("group_chat").orderBy("dateTime",descending: true).snapshots();
    Stream queryStream = querySnapShotStream.map((event) => event.docs.map((e) => e.data()).toList());
    queryStream.listen((messages) {
      add(MessageReceivedEvent(messages: Message.getMessageList(messages)));
    });
  }

  void onMessageReceived(MessageReceivedEvent event, Emitter emit){
    emit(MessageReceivedSuccess(messages: event.messages));
  }

  void onMessageSend(SendMessageEvent event, Emitter emit) async{
    emit(MessageReceivedLoading());
    print(DateTime.now().microsecondsSinceEpoch);
    var message = {
      "userId": user?.uid,
      "userImage": user?.photoURL,
      "dateTime": DateTime.now().microsecondsSinceEpoch,
      "content": event.content,
      "contentImage": "img"};
    await fireStore.collection("group_chat").add(message);
    emit(MessageSendSuccess());
  }

}
