import 'package:flutter/material.dart';
import 'package:flutter_chats_app/utils/app_colors.dart';

class ChatMessageSample extends StatelessWidget {
  final bool isMeChatting;
  final String messageBody;

  const ChatMessageSample({super.key, required this.isMeChatting, required this.messageBody});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMeChatting ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.65,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: isMeChatting ? const BorderRadius.only(
            topLeft: Radius.circular(12),
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ) : const BorderRadius.only(
            topRight: Radius.circular(12),
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
          color: isMeChatting ? AppColors.primaryColor2 : Colors.grey[200],
        ),
        margin: const EdgeInsets.all(8),
        child: Text(
          messageBody,
          style: TextStyle(
            fontSize: 15,
            color: isMeChatting ? Colors.white : AppColors.blackColor,
          ),
          textAlign: TextAlign.start,
        ),
      ),
    );
  }
}