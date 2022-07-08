import 'dart:math';

import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {

  final String content;
  final String date;
  final bool isMe;

  const ChatItem({
    Key? key,
    required this.content,
    required this.date,
    required this.isMe
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if(!isMe) const Padding(
            padding: EdgeInsets.all(5),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage("assets/images/profile_pic.jpeg"),
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
                    painter: ChatBubbleTriangle(color: isMe ? Colors.deepPurple : const Color(0xFFF0F0F0)),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                constraints: const BoxConstraints(minWidth: 50, maxWidth: 300),
                decoration: BoxDecoration(
                  color: isMe ? Colors.deepPurple : const Color(0xFFF0F0F0),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    Text(content, style: TextStyle(color: isMe ? Colors.white : Colors.black)),
                    const SizedBox(height: 5,),
                    Text(date, style: TextStyle(
                      fontSize: 10,
                      color: isMe ? Colors.white54 : Colors.black45, fontWeight: FontWeight.w600, )),
                  ],
                ),
              ),
            ],
          ),
          if(isMe) const Padding(
            padding: EdgeInsets.all(5),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage("assets/images/profile_pic.jpeg"),
            ),
          ),
        ],
      ),
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
