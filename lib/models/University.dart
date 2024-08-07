import 'package:flutter_chats_app/models/Member.dart';

class University {
  String id;
  String? code;
  String? name;
  List<Member> members;

  University({
    required this.id,
    this.code,
    this.name,
    required this.members,
  });

  // Phương thức từ JSON
  factory University.fromJson(Map<String, dynamic> json) {
    return University(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      members: [],
    );
  }

  // Phương thức to JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'code': code,
        'name': name,
        'members': List<dynamic>.from(members.map((x) => x.toJson())),
      };
}
