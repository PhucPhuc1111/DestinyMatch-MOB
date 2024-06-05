import 'dart:convert';
import 'package:destinymatch/models/Account.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class Accountservice {
  final String apiLink = "https://localhost:7016";

  Accountservice();

  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse("${apiLink}/api/Accounts/login");
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body:
          jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      // final storage = new FlutterSecureStorage();
      // await storage.write(key: "account", value: response.body);
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      print(responseBody);
      return responseBody;
    } else {
      return {"error": "Login failed"};
    }
  }
}
