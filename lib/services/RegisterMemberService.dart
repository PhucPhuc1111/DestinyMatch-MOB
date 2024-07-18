import 'dart:convert';
import 'package:flutter_chats_app/models/Hobby.dart';
import 'package:flutter_chats_app/models/Major.dart';
import 'package:flutter_chats_app/models/MemberRequest%20.dart';
import 'package:flutter_chats_app/models/University.dart';
import 'package:http/http.dart' as http;

class RegisterMemberService {
  final String apiLink = "https://destiny-match.azurewebsites.net/api";

  RegisterMemberService();

  Future<bool> register(MemberRequest request) async {
    final url = Uri.parse("$apiLink/member");
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': '*/*',
      },
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      print("Registration failed: ${response.body}");
      return false;
    }
  }

  Future<List<University>> fetchUniversities() async {
    final url = Uri.parse("$apiLink/university");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final List<dynamic> universityJson = jsonResponse['data'];
      return universityJson.map((data) => University.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load universities');
    }
  }

  Future<List<Major>> fetchMajors() async {
    final url = Uri.parse("$apiLink/major");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Decode the JSON response
      final jsonResponse = json.decode(response.body);

      // Extract the list of majors from the response
      final List<dynamic> majorsJson = jsonResponse['majors'];

      // Map the JSON list to a List<Major>
      return majorsJson.map((data) => Major.fromJson(data)).toList();
    } else {
      print('Failed to load majors: ${response.body}');
      throw Exception('Failed to load majors');
    }
  }
  Future<List<Hobby>> fetchHobbies() async {
  final url = Uri.parse("$apiLink/hobby");
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    final List<dynamic> hobbiesJson = jsonResponse['hobbies'];
    return hobbiesJson.map((data) => Hobby.fromJson(data)).toList();
  } else {
    print('Failed to load hobbies: ${response.body}');
    throw Exception('Failed to load hobbies');
  }
}
}
