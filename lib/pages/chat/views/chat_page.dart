import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_learn/pages/chat/view_models/chat_view_model.dart';
import 'package:t_learn/pages/chat/widgets/chat_input.dart';
import 'package:t_learn/pages/chat/widgets/chat_item.dart';
import 'package:t_learn/utils/constants.dart';
import 'package:t_learn/utils/globals.dart';
import 'package:t_learn/utils/utils.dart';
import 'package:t_learn/widgets/background.dart';
import '../blocs/chat_bloc/chat_bloc.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
        title: "${Globals.exam} group",
        isBackPressed: true,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: const MainBody()
    );
  }
}

class MainBody extends StatelessWidget {
  const MainBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Expanded(child: ChatList()),
        ChatInput()
      ],
    );
  }
}

class ChatList extends StatelessWidget {

  const ChatList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final ChatViewModel viewModel = ChatViewModel();

    return BlocBuilder<ChatBloc,ChatState>(
        builder: (_,state){

          if(state is MessageReceivedLoading){
            return Wrap(children: const [Utils.buttonProgressIndicator]);
          }else if(state is MessageReceivedSuccess || state is MessageSendSuccess){

            if(state is MessageReceivedSuccess){
              viewModel.messages = state.messages;
            }

            return ListView.builder(
                itemCount: viewModel.messages.length,
                reverse: true,
                itemBuilder: (_,index){
                  return Row(
                      mainAxisAlignment: viewModel.messages[index].isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                      children: [
                        ChatItem(
                          userImage: viewModel.messages[index].userImage??commonAvatar,
                          contentId: viewModel.messages[index].contentId,
                          contentImg: viewModel.messages[index].contentImage,
                          content: viewModel.messages[index].content,
                          date: viewModel.messages[index].dateTime,
                          isMe: viewModel.messages[index].isMe,
                        ),
                      ]
                  );
                }
            );
          }else{
            return const SizedBox();
          }
        });
  }
}


