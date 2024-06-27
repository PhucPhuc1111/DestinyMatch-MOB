import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chats_app/utils/app_colors.dart';
import 'package:flutter_chats_app/widgets/bottom_chat_sheet.dart';
import 'package:flutter_chats_app/widgets/chat_message_sample.dart';

class ChatSceen extends StatelessWidget {
  const ChatSceen({super.key});

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
                        "Jones Noa",
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
              child: ListView(
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 70),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Today",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  ChatMessageSample(
                    isMeChatting: true,
                    messageBody: "hi, how are you?",
                  ),
                  ChatMessageSample(
                    isMeChatting: false,
                    messageBody: "I am fine what aout your?",
                  ),
                  ChatMessageSample(
                    isMeChatting: true,
                    messageBody: "hi, how are you?",
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomChatSheet(),
    );
  }
}
