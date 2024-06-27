import 'package:flutter_chats_app/models/Member.dart';

class Hobby {
  String id;
  String? name;
  String? description;
  List<Member> members;

  Hobby({
    required this.id,
    this.name,
    this.description,
    this.members = const [], // Initialize with an empty list
  });

  // Method to create Hobby object from JSON
  factory Hobby.fromJson(Map<String, dynamic> json) {
    return Hobby(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      members: List<Member>.from(
          json['members'].map((x) => Member.fromJson(x))),
    );
  }

  // Method to convert Hobby object to JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'members': List<dynamic>.from(members.map((x) => x.toJson())),
      };
}
