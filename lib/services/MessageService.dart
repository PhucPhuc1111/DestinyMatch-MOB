import 'dart:convert';
import 'package:http/http.dart' as http;

class Messageservice {
  final String apiLink = "http://10.0.2.2:5107/api";
  //final String apiLink = "http://localhost:5107/api";
  //final String apiLink = "https://destiny-match.azurewebsites.net/api";
  Future<List<dynamic>> getMessages(String matchingid) async {
    final url = Uri.parse("$apiLink/message/conversation/$matchingid");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData;
    } else {
      throw Exception('Failed to load messages');
    }
  }

  Future<void> sendMessage(
      String matchid, String senderId, String content, String status) async {
    final url = Uri.parse("$apiLink/message");
    var body = jsonEncode({
      "content": content,
      "status": status,
      "match-id": matchid,
      "sender-id": senderId
    });

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode != 200) {
      print("Error: ${response.statusCode}, ${response.body}");
      throw Exception("Failed to send message: ${response.body}");
    }
  }

  Future<void> SendNotification(
      String fcmtoken, String title, String notificationBody) async {
    final url = Uri.parse("$apiLink/firebase/send-notification");
    var requestBody = jsonEncode({
      "fcmtoken": fcmtoken,
      "title": title,
      "body": notificationBody,
    });
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: requestBody,
    );
    print("send notification response: ${response.body}");
  }
}
