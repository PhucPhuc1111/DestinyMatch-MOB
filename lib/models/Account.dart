import 'package:flutter_chats_app/models/Member.dart';


class Account {
  String id;
  String? email;
  String? password;
  DateTime? createAt;
  String role;
  String? status;
  Member? member;

  Account({
    required this.id,
    this.email,
    this.password,
    this.createAt,
    required this.role,
    this.status,
    this.member,
  });

  // Phương thức từ JSON
  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'],
      email: json['email'],
      password: json['password'],
      createAt: json['createAt'] != null ? DateTime.parse(json['createAt']) : null,
      role: json['role'],
      status: json['status'],
      member: json['member'] != null ? Member.fromJson(json['member']) : null,
    );
  }

  // Phương thức to JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'password': password,
        'createAt': createAt?.toIso8601String(),
        'role': role,
        'status': status,
        'member': member?.toJson(),
      };
}
