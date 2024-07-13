import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class Matchingservice {
  final String apiLink = "https://localhost:7215/api";
  //final String apiLink = "https://destiny-match.azurewebsites.net/api";
  Matchingservice();

  Future<List<dynamic>> getListMatching() async {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: "token");
   final url = Uri.parse(
        "$apiLink/matching/get-current-user-conversation?pageIndex=1&pageSize=10&status=success");
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);

      return jsonData;
    } else {
      throw Exception('Failed to load matching list');
    }
  }
}
