import 'dart:convert';
import 'package:destinymatch/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Accountservice {
  final String apiLink = "https://localhost:7215";
  //final String apiLink = "http://192.168.1.12:7215";

  Accountservice();

  Future<void> login(
      BuildContext context, String email, String password) async {
    final url = Uri.parse("$apiLink/api/accounts/login");
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
      print(responseBody);

      // Giả sử API trả về một token trong response
      String token = responseBody['token'];

      // Lưu token vào Flutter Secure Storage
      await storage.write(key: "token", value: token);
      print(token);
      // Hoặc lưu trữ thông tin người dùng vào Shared Preferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', jsonEncode(responseBody['token']));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const MyHomePage(title: "hello")),
      );
    } else {
      print({"error": "Login failed"});
    }
  }

  Future<bool> checkAccountLogin() async {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: "token");
    
    return token != null;
  }
}
