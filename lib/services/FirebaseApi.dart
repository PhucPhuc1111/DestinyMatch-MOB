import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FirebaseApi {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> initPermission() async {
    await _messaging.requestPermission();
    // String? fcmToken = await _messaging.getToken();
    // print("FCM token: $fcmToken");

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Message received in foreground: ${message.data}');
      handleMessage(message);
    });

    // Handle messages when the app is opened from the background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message opened from background: ${message.data}');
      handleMessage(message);
    });

    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  void handleMessage(RemoteMessage message) {
    print('Handling message: ${message.data}');
    // Add your custom handling logic here
  }

  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print('Message received in background: ${message.data}');
    // Handle your message here
  }
}
