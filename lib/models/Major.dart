import 'package:flutter_chats_app/models/Member.dart';

class Major {
  String id;
  String? code;
  String? name;
  List<Member> members;

  Major({
    required this.id,
    this.code,
    this.name,
    this.members = const [], // Initialize with an empty list
  });

  // Method to create Major object from JSON
  factory Major.fromJson(Map<String, dynamic> json) {
    return Major(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      members: List<Member>.from(
          json['members'].map((x) => Member.fromJson(x))),
    );
  }

  // Method to convert Major object to JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'code': code,
        'name': name,
        'members': List<dynamic>.from(members.map((x) => x.toJson())),
      };
}
