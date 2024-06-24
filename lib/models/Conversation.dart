import 'package:destinymatch/models/Member.dart';
import 'package:destinymatch/models/Message.dart';

class Conversation {
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

  Conversation({
    required this.id,
    this.firstName,
    this.secondName,
    this.recentlyActivity,
    this.createdAt,
    this.status,
    required this.firstMemberId,
    required this.secondMemberId,
    required this.firstMember,
    required this.messages,
    required this.secondMember,
  });

  // Phương thức từ JSON
  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: json['id'],
      firstName: json['firstName'],
      secondName: json['secondName'],
      recentlyActivity: json['recentlyActivity'] != null
          ? DateTime.parse(json['recentlyActivity'])
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      status: json['status'],
      firstMemberId: json['firstMemberId'],
      secondMemberId: json['secondMemberId'],
      firstMember: Member.fromJson(json['firstMember']),
      messages: List<Message>.from(
          json['messages'].map((x) => Message.fromJson(x))),
      secondMember: Member.fromJson(json['secondMember']),
    );
  }

  // Phương thức to JSON
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
