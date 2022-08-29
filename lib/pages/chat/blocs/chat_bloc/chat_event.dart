part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class RequestMessageEvent extends ChatEvent {}

class MessageReceivedEvent extends ChatEvent {
  final List<Message> messages;

  MessageReceivedEvent({required this.messages});
}

class SendMessageEvent extends ChatEvent {
  final String content;
  final String? contentImage;

  SendMessageEvent({required this.content, required this.contentImage});
}

class DeleteMessageEvent extends ChatEvent {
  final String contentId;

  DeleteMessageEvent({required this.contentId});
}