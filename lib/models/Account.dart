import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Account {
  String id;
  String? email;
  String? password;
  DateTime? createAt;
  String role;
  String? status;

  Account({
    required this.id,
    required this.email,
    required this.password,
    required this.createAt,
    required this.role,
    required this.status,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'] as String,
      email: json['email'] as String?,
      password: json['password'] as String?,
      createAt: DateTime.parse(json['createat'] as String),
      role: json['role'] as String,
      status: json['status'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'createat': createAt?.toIso8601String(),
      'role': role,
      'status': status,
    };
  }
}