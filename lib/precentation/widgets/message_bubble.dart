import 'package:flutter/material.dart';
import 'package:quagga/utils/colors.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, required this.isMe, required this.message});
  final bool isMe;
  final String message;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 5),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(12),
                topRight: const Radius.circular(12),
                bottomLeft: Radius.circular(isMe ? 12 : 0),
                bottomRight: Radius.circular(isMe ? 0 : 12)),
            color: isMe ? Colors.grey.withOpacity(0.2) : kLightBlueColor,
          ),
          child: Text(
            message,
            style: TextStyle(
              color: kWhite,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
