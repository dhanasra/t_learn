import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:t_learn/pages/chat/bloc/chat_bloc.dart';
import 'package:t_learn/pages/chat/view_models/chat_view_model.dart';

class ChatInput extends StatelessWidget {
  const ChatInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final ChatViewModel viewModel = ChatViewModel();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
            child: TextField(
                maxLines: 4,
                minLines: 1,
                controller: viewModel.chatInputController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFF0F0F0),
                    hintText: "Write message",
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
                    suffixIcon: IconButton(
                      onPressed: (){},
                      splashRadius: 20,
                      icon: const Icon(FontAwesomeIcons.image, color: Colors.grey,size: 18,),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),borderSide: const BorderSide(color: Colors.transparent)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),borderSide: const BorderSide(color: Colors.transparent))
                ),
              ),
            ),
            const SizedBox(width: 10,),
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.deepPurpleAccent,
                child: IconButton(
                  onPressed: (){
                    BlocProvider.of<ChatBloc>(context).add(SendMessageEvent(
                        content: viewModel.chatInputController.text, contentImage: "img"));
                    viewModel.chatInputController.text = "";
                  },
                  splashRadius: 20,
                  icon: const Icon(Icons.send, color: Colors.white,size: 18,),
                  )
            )
      ],
    );
  }
}
