import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chats_app/models/Message.dart';
import 'package:flutter_chats_app/services/MessageService.dart';
import 'package:flutter_chats_app/utils/app_colors.dart';
import 'package:flutter_chats_app/widgets/bottom_chat_sheet.dart';
import 'package:flutter_chats_app/widgets/chat_message_sample.dart';

class ChatScreen extends StatefulWidget {
  final String matchingId;

  ChatScreen({Key? key, required this.matchingId}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Messageservice messageservice = Messageservice();
  List<dynamic> messages = [];

  @override
  void initState() {
    super.initState();
    fetchConversation(); // Gọi hàm để tải dữ liệu
  }

  Future<void> fetchConversation() async {
    try {
      var data = await messageservice.getMessages(widget.matchingId);
      setState(() {
        messages = data;
      });
    } catch (e) {
      print("Error fetching conversation: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: Container(
          padding: EdgeInsets.only(top: 5),
          margin: EdgeInsets.zero,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                spreadRadius: 2,
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.white,
            leadingWidth: 40,
            leading: Padding(
              padding: EdgeInsets.only(left: 15),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  CupertinoIcons.arrow_left,
                  size: 25,
                  color: AppColors.primaryColor2,
                ),
              ),
            ),
            title: Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(
                        "assets/images/Jones Noa.jpg",
                      ),
                      minRadius: 25,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(2.5),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2.5),
                        ),
                        child: Icon(
                          Icons.brightness_1,
                          size: 8,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Jones Hello",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryColor2,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        "Active Now",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  return ChatMessageSample(
                    isMeChatting: message.senderId == "4775bb8c-cba0-4353-8115-6788e7bcc45e",
                    messageBody: message.content,
                  );
                },
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomChatSheet(),
    );
  }
}
