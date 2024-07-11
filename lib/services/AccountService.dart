import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Accountservice {
  final String apiLink = "https://localhost:7215/api";
  //final String apiLink = "https://destiny-match.azurewebsites.net";

  Accountservice();

  Future<bool> login(String email, String password) async {
    final url = Uri.parse("$apiLink/accounts/login");
    const storage = FlutterSecureStorage();
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      //print(responseBody);

      String token = responseBody['token'];

      // Lưu token vào Flutter Secure Storage
      await storage.write(key: "token", value: token);
      //print(token);
      // Hoặc lưu trữ thông tin người dùng vào Shared Preferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', jsonEncode(responseBody['token']));
      return true;
    } else {
      print({"error": "Login failed"});
      return false;
    }
  }

  Future<bool> checkAccountLogin() async {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: "token");
    
    return token != null;
  }
}
