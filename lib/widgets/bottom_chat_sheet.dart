import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chats_app/utils/app_colors.dart';

class BottomChatSheet extends StatelessWidget {
  const BottomChatSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 10,
          offset: Offset(0, 3),
        ),
      ]),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: Icon(
              Icons.add,
              color: AppColors.primaryColor2,
              size: 30,
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 10),
              child: Container(
                alignment: Alignment.centerRight,
                width: MediaQuery.of(context).size.width / 1.8,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "type Something",
                    border: InputBorder.none,
                  ),
                ),
              )),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.send,
              color: AppColors.primaryColor2,
              size: 30,
            ),
          )
        ],
      ),
    );
  }
}
