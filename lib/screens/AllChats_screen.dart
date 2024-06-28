import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chats_app/screens/chat_sceen.dart';
import 'package:flutter_chats_app/utils/app_colors.dart';

class AllChatScreen extends StatefulWidget {
  @override
  _AllChatScreenState createState() => _AllChatScreenState();
}

class _AllChatScreenState extends State<AllChatScreen> {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    _requestPermissionsAndGetToken();
    _listenToNotifications();
  }

  Future<void> _requestPermissionsAndGetToken() async {
    // Request permissions
    final settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    String? token = await _messaging.getToken();

    print(token);
  }

  void _listenToNotifications() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }

  final List<String> images = [
    "assets/images/Christine.jpg",
    "assets/images/Davis.jpg",
    "assets/images/Johnson.jpg",
    "assets/images/Jones Noa.jpg",
    "assets/images/Parker Bee.jpg",
    "assets/images/Smith.jpg",
  ];

  final List<String> names = [
    "Christine",
    "Davis",
    "Johnson",
    "Jones Noa",
    "Parker Bee",
    "Smith",
  ];

  final List<String> msgTiming = [
    "Mon",
    "12:30",
    "Sun",
    "05:41",
    "22:12",
    "Wed",
  ];

  final List<String> msgs = [
    "Hi, how are you?",
    "Where are you from?",
    "Hello, is all right?",
    "It is nice to meet you",
    "Good morning",
    "Good morning",
  ];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: media.width * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Chats",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      color: AppColors.blackColor,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            CupertinoIcons.pen,
                            size: 30,
                          )),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: media.width * 0.05),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              margin: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Search",
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.search),
                ),
              ),
            ),
            SizedBox(height: media.width * 0.02),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Divider(thickness: 1),
            ),
            SizedBox(height: media.width * 0.02),
            ListView.builder(
                itemCount: images.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatSceen(),
                          ),
                        );
                      },
                      leading: CircleAvatar(
                        maxRadius: 28,
                        backgroundImage: AssetImage(images[index]),
                      ),
                      title: Text(
                        names[index],
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        msgs[index],
                        style: TextStyle(
                          color: AppColors.grayColor,
                        ),
                      ),
                      trailing: Text(msgTiming[index]),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
