part of 'chat_bloc.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class MessageReceivedSuccess extends ChatState {
  final List<Message> messages;

  MessageReceivedSuccess({
    required this.messages
  });
}

class MessageReceivedLoading extends ChatState {}

class MessageSendLoading extends ChatState {}

class MessageSendSuccess extends ChatState {}