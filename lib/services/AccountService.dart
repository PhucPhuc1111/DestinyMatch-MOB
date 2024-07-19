import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_chats_app/services/FirebaseApi.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class Accountservice {
  //final String apiLink = "http://10.0.2.2:5107/api";
  //final String apiLink = "http://localhost:5107/api";
  //final String apiLink = "https://destinymatch.serveo.net/api";
  final String apiLink = "https://destiny-match.azurewebsites.net/api";

  final storage = const FlutterSecureStorage();
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  Accountservice();

  Future<bool> login(String email, String password) async {
    FirebaseApi firebaseApi = FirebaseApi();
    final url = Uri.parse("$apiLink/accounts/login");
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({"email": email, "password": password}),
    );
    print("loginin g");
    if (response.statusCode == 201) {
      print("Login success");
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      String token = responseBody['token'];

      // Lưu token vào Flutter Secure Storage
      await storage.write(key: "token", value: token);
      
      String? fcmToken = await _messaging.getToken();
      await setFcmTokenThisDevice(fcmToken.toString());


      // Giải mã token để lấy id
      final jwt = JwtDecoder.decode(token); // Sử dụng JwtDecoder để giải mã token
      String userId = jwt['sub']; // Lấy ID từ payload của token



      //print(token);
      // Hoặc lưu trữ thông tin người dùng vào Shared Preferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      // Lưu id vào Shared Preferences
      await prefs.setString('userId', userId);
      await prefs.setString('token', jsonEncode(responseBody['token']));
      return true;
    } else {
      print({"error": "Login failed"});
      return false;
    }
  }

  Future<bool> register(String email, String password, bool receiveEmail) async {
    final url = Uri.parse("$apiLink/accounts/register");
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "email": email,
        "password": password,
        "receivenotifiemail": receiveEmail,
      }),
    );
    print("response:");print(response);
    print("response body:");print(response.body);
    print(response.statusCode);
    if (response.statusCode == 201) {
      return true;
    } else {
      print({"error": "Register failed"});
      return false;
    }
  }

   Future<bool> checkAccountExists(String accountId) async {
  if (accountId == null || accountId.isEmpty) {
    print('AccountId is null or empty');
    return false;
  }

  final url = Uri.parse("$apiLink/member/exists?accountId=$accountId");
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    return jsonResponse == true;
  } else {
    print('Failed to check account existence: ${response.body}');
    return false;
  }
}

  Future<bool> checkAccountLogin() async {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: "token");
    return token != null;
  }

  Future<void> logOut() async {
    await storage.delete(key: "token");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  Future<void> setFcmTokenThisDevice(String fcmToken) async {
    final url = Uri.parse("$apiLink/accounts/update-fcmtoken?fcmtoken=$fcmToken");
    var token = await storage.read(key: "token");
    final response = await http.put(url, headers: {'Authorization': 'Bearer ${token}'});
    print(response);
  }
}
