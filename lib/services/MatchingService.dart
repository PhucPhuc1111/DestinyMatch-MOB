import 'dart:convert';

import 'package:flutter_chats_app/models/Matching.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class Matchingservice {
  final String apiLink = "https://localhost:7215/api";

  Matchingservice();

   Future<List<Matching>> getListMatching() async {
    final storage = await FlutterSecureStorage();
    var token = await storage.read(key: "token");
    token ??= "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyMTlkNjRmZC0xMGJhLTQyZmQtYTkxYy0wOTc2ODUyYmRkNDkiLCJlbWFpbCI6InVzZXJAZXhhbXBsZS5jb20iLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJtZW1iZXIiLCJtZW1iZXJpZCI6IjgyNWE4NTI5LTY5M2QtNDM0Yi04Yjg4LWRjMGY5MGE2OWY4ZSIsImV4cCI6MTcxOTU4Njk5MywiaXNzIjoiaHR0cHM6IC8vbG9jYWxob3N0OjcwMTYiLCJhdWQiOiJodHRwczogLy9sb2NhbGhvc3Q6NzAxNiJ9.T2LVeCFbbowsL95vKBYdu-QBD9q2l-ZSKPOsfJtt_1g";
    final url = Uri.parse("$apiLink/matching/get-current-user-conversation?pageIndex=1&pageSize=10");
    final response = await http.get(url, 
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    }
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      print(jsonData);
      return jsonData.map((item) => Matching.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load matching list');
    }
}

}
