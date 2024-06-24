import 'dart:convert';

import 'package:destinymatch/models/Member.dart';
import 'package:http/http.dart' as http;

class Conversationservice {
  final String apiLink = "https://localhost:7215/api";

  Conversationservice();

   Future<List<Member>> getListMember() async {
    final url = Uri.parse("$apiLink/member");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((item) => Member.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load members');
    }
}

}
