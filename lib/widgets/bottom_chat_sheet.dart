import 'package:flutter/material.dart';
import 'package:flutter_chats_app/services/MessageService.dart';
import 'package:flutter_chats_app/utils/app_colors.dart';
import 'package:signalr_core/signalr_core.dart';

class BottomChatSheet extends StatefulWidget {
  final String matchingId, senderId;
  final HubConnection hubConnection;
  const BottomChatSheet(
      {super.key,
      required this.matchingId,
      required this.senderId,
      required this.hubConnection});

  @override
  State<BottomChatSheet> createState() => _BottomChatSheetState();
}

class _BottomChatSheetState extends State<BottomChatSheet> {
  Messageservice messageservice = Messageservice();
  TextEditingController content = TextEditingController();

  void sendMessage(String content) async {
    await messageservice.sendMessage(
        widget.matchingId, widget.senderId, content, "sent");
  }

void _sendMessageRealTime() async {
  try {
    await widget.hubConnection.invoke('SendMessage', args: [widget.matchingId, widget.senderId, content.text]);
    content.text = ""; // Clear text field after sending message
  } catch (e) {
    print("Error sending message: $e");
  }
}


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 10,
          offset: const Offset(0, 3),
        ),
      ]),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8),
            child: Icon(
              Icons.add,
              color: AppColors.primaryColor2,
              size: 30,
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Container(
                alignment: Alignment.centerRight,
                width: MediaQuery.of(context).size.width / 1.8,
                child: TextFormField(
                  controller: content,
                  decoration: const InputDecoration(
                    hintText: "type Something",
                    border: InputBorder.none,
                  ),
                ),
              )),
          const Spacer(),
          Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkWell(
                onTap: () {
                  sendMessage(content.text);
                  _sendMessageRealTime();
                  content.text = "";
                },
                child: const Icon(
                  Icons.send,
                  color: AppColors.primaryColor2,
                  size: 30,
                ),
              ))
        ],
      ),
    );
  }
}
