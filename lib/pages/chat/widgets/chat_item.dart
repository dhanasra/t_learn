import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:t_learn/pages/chat/blocs/chat_bloc/chat_bloc.dart';
import 'package:t_learn/pages/chat/widgets/chat_item_wrapper.dart';
import 'package:t_learn/utils/utils.dart';
import 'package:t_learn/utils/widgets/constants.dart';
import 'package:t_learn/widgets/loading.dart';

class ChatItem extends StatelessWidget {

  final String content;
  final String? contentImg;
  final String contentId;
  final int date;
  final bool isMe;
  final String userImage;

  const ChatItem({
    Key? key,
    required this.contentImg,
    required this.content,
    required this.contentId,
    required this.date,
    required this.isMe,
    required this.userImage
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ValueNotifier deleteShow = ValueNotifier<bool>(false);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onLongPress: ()=>deleteShow.value = true,
        child: Column(
          crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            ValueListenableBuilder(
                valueListenable: deleteShow,
                builder: (_, isDeleteShow, child){
                  if(deleteShow.value && isMe){
                    return InkWell(
                      onTap: ()=>BlocProvider.of<ChatBloc>(context).add(DeleteMessageEvent(contentId: contentId)),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(4)
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.close, color: Colors.white,),
                          ],
                        ),
                      ),
                    );
                  }else{
                    return const SizedBox();
                  }
                }
            ),
            if(contentImg!=null) ChatItemWrapper(
              isMe: isMe,
              date: date,
              userImage: userImage,
              isImage: true,
              child: GestureDetector(
                onTap: ()=>showImageBottomSheet(context),
                child: Image.network(contentImg!, fit: BoxFit.cover, loadingBuilder: (context,child,loadingProgress){
                  return loadingProgress==null
                      ? child
                      : const SizedBox(width: 100, height: 100, child: Loading(type: shimmer_1),);
                },),
              ),
            ),
            if(contentImg!=null) Utils.verticalDividerMedium,
            if(content.isNotEmpty) ChatItemWrapper(
              isMe: isMe,
              date: date,
              userImage: userImage,
              isImage: false,
              child: Text(content, style: TextStyle(color: isMe ? Colors.white : Colors.black)),
            )
          ],
        ),
      ),
    );
  }

  void showImageBottomSheet(BuildContext context){
    showModalBottomSheet(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        enableDrag: false,
        shape: const RoundedRectangleBorder( borderRadius: BorderRadius.vertical(
            top: Radius.circular(25) ),),
        barrierColor: Theme.of(context).shadowColor.withOpacity(0.6),
        context: context, builder: (BuildContext context) {
          return Container(
            height: 450,
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: ()=>Navigator.pop(context),
                  child: const Icon(FontAwesomeIcons.x, color: Colors.grey,),
                ),
                Expanded(child: InteractiveViewer(
                  minScale: 0.1,
                  maxScale: 2,
                  boundaryMargin: const EdgeInsets.all(10),
                  child: Center(
                    child: Image.network(contentImg!, fit: BoxFit.contain),
                  ),
                ))
              ],
            ),
          );
    });
  }
}


