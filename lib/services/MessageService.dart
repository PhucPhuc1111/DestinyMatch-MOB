import 'dart:convert';
import 'package:flutter_chats_app/models/Message.dart';
import 'package:http/http.dart' as http;

class Messageservice {
  final String apiLink = "https://localhost:7215/api";

  Future<List<Message>> getMessages(String matchingid) async {
    final url = Uri.parse("$apiLink/message/conversation/$matchingid");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      List<Message> messages = jsonData.map((e) => Message.fromJson(e)).toList();
      return messages;
    } else {
      throw Exception('Failed to load messages');
    }
  }
}
