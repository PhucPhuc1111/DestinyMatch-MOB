import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:destinymatch/widgets/ConversationCard.dart';
import 'package:http/http.dart' as http;

class ConversationPage extends StatefulWidget {
  const ConversationPage({super.key});

  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  final TextEditingController _textController = TextEditingController();
  final messaging = FirebaseMessaging.instance;
  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _requestPermissionsAndGetToken();
    _listenToNotifications();
  }

  Future<void> _requestPermissionsAndGetToken() async {
    // Request permissions
    final settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  Future<void> _sendTokenToServer() async {
    try {
      // Get the FCM token
      String? token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        print('Sending token to server: $token');
      }

      //Replace this with your server-side code to handle the token
      final response = await http.post(
        Uri.parse(
            'https://localhost:7215/api/firebase/send-notification?fcmToken=$token'),
        body: {
          'fcmToken': token,
          'title': 'Test Title',
          'body': 'Test Body',
        },
      );

      if (response.statusCode == 200) {
        print('Token sent to server successfully');
      } else {
        print('Error sending token to server: ${response.statusCode}');
      }
    } catch (e) {
      print('Error getting FCM token: $e');
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Members List'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const BackButton(),
                  Expanded(
                      child: SearchBar(
                    controller: _textController,
                    onTap: () async {
                      print("test");
                    },
                  )),
                  const SizedBox(width: 10),
                  IconButton(icon: const Icon(Icons.search), onPressed: () {})
                ],
              ),
            ),
            Expanded(child: Conversationcard()),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await _sendTokenToServer();
          },
          child: const Icon(Icons.chat),
        ));
  }
}
