import 'package:flutter_chats_app/models/Member.dart';
import 'package:flutter_chats_app/models/Message.dart';

class Matching {
  String id;
  String? firstName;
  String? secondName;
  DateTime? recentlyActivity;
  DateTime? createdAt;
  String? status;
  String firstMemberId;
  String secondMemberId;
  Member firstMember;
  List<Message> messages;
  Member secondMember;

  Matching({
    required this.id,
    this.firstName,
    this.secondName,
    this.recentlyActivity,
    this.createdAt,
    this.status,
    required this.firstMemberId,
    required this.secondMemberId,
    required this.firstMember,
    this.messages = const [], // Initialize with an empty list
    required this.secondMember,
  });

  // Method to create Matching object from JSON
  factory Matching.fromJson(Map<String, dynamic> json) {
    return Matching(
      id: json['id'],
      firstName: json['firstName'],
      secondName: json['secondName'],
      recentlyActivity: json['recentlyActivity'] == null
          ? null
          : DateTime.parse(json['recentlyActivity']),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt']),
      status: json['status'],
      firstMemberId: json['firstMemberId'],
      secondMemberId: json['secondMemberId'],
      firstMember: Member.fromJson(json['firstMember']),
      messages: List<Message>.from(
          json['messages'].map((x) => Message.fromJson(x))),
      secondMember: Member.fromJson(json['secondMember']),
    );
  }

  // Method to convert Matching object to JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'secondName': secondName,
        'recentlyActivity': recentlyActivity?.toIso8601String(),
        'createdAt': createdAt?.toIso8601String(),
        'status': status,
        'firstMemberId': firstMemberId,
        'secondMemberId': secondMemberId,
        'firstMember': firstMember.toJson(),
        'messages': List<dynamic>.from(messages.map((x) => x.toJson())),
        'secondMember': secondMember.toJson(),
      };
}
