import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Accountservice {
  final String apiLink = "https://localhost:7016";

  Accountservice();

  Future<void> login(String email, String password) async {
    final url = Uri.parse("$apiLink/api/Accounts/login");
    final storage = FlutterSecureStorage();
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      print(responseBody);

      // Giả sử API trả về một token trong response
      String token = responseBody['token'];

      // Lưu token vào Flutter Secure Storage
      await storage.write(key: "token", value: token);

      // Hoặc lưu trữ thông tin người dùng vào Shared Preferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', jsonEncode(responseBody['token']));

    } else {
      print({"error": "Login failed"});
    }
  }
}
