import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_learn/pages/chat/bloc/chat_bloc.dart';
import 'package:t_learn/pages/chat/view_models/chat_view_model.dart';
import 'package:t_learn/pages/chat/widgets/chat_input.dart';
import 'package:t_learn/pages/chat/widgets/chat_item.dart';

import '../../../widgets/custom_app_bar.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomAppBar.leadingIcon(),
        title: CustomAppBar.title("Group Chat 10"),
        actions: [ CustomAppBar.actionIcon(Icons.segment,(){}) ],
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        foregroundColor: Colors.deepPurpleAccent,
      ),
      backgroundColor: Colors.white ,
      body: BlocProvider(
        create: (_)=>ChatBloc()..add(RequestMessageEvent()),
        child:const Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: MainBody(),
          ))
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

  const ChatList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final ChatViewModel viewModel = ChatViewModel();

    return BlocBuilder<ChatBloc,ChatState>(
        builder: (_,state){

          if(state is MessageReceivedLoading){
            return Wrap(children: const [CircularProgressIndicator()],);
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
                          content: viewModel.messages[index].content,
                          date: viewModel.messages[index].dateTime.toString(),
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


