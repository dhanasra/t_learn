import 'dart:math';

import 'package:flutter/material.dart';
import 'package:t_learn/utils/constants.dart';
import 'package:t_learn/utils/date_utils.dart';
import 'package:t_learn/utils/globals.dart';
import 'package:t_learn/utils/utils.dart';

class ChatItemWrapper extends StatelessWidget {

  final bool isMe;
  final bool isImage;
  final Widget child;
  final int date;
  final String userImage;

  const ChatItemWrapper({
    Key? key,
    required this.isMe,
    required this.child,
    required this.date,
    required this.isImage,
    required this.userImage
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if(!isMe) Padding(
          padding: const EdgeInsets.all(5),
          child: CircleAvatar(
            radius: 15,
            backgroundImage: NetworkImage(userImage),
          ),
        ),
        Stack(
          children: [
            Positioned(
              bottom: 0,
              right: isMe ? 0 : null,
              child: Transform(
                transform: Matrix4.rotationY(isMe ? pi : 0),
                child: CustomPaint(
                  painter: ChatBubbleTriangle(color: isMe ? primaryColor : Theme.of(context).canvasColor),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(isImage ? 5 : 10),
              constraints: BoxConstraints(minWidth: 50, maxWidth: isImage ? 200 : 300),
              decoration: BoxDecoration(
                color: isMe ? primaryColor : Theme.of(context).canvasColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  child,
                  Utils.verticalDividerMedium,
                  Text(
                      DateTimeUtils.formatDate(date),
                      style: TextStyle(
                        fontSize: 10,
                        color: isMe ? Colors.white54 : Colors.black45, fontWeight: FontWeight.w600, )),
                ],
              ),
            )
          ],
        ),
        if(isMe) Padding(
          padding: const EdgeInsets.all(5),
          child: CircleAvatar(
            radius: 15,
            backgroundImage: NetworkImage(Globals.photo),
          ),
        ),
      ],
    );
  }
}

class ChatBubbleTriangle extends CustomPainter {

  final Color color;

  ChatBubbleTriangle({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = color;

    var path = Path();
    path.lineTo(-20, 0);
    path.quadraticBezierTo(10, -10, 5, -70);
    path.lineTo(10, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

