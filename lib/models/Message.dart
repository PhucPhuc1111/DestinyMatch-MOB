import 'matching.dart';
import 'member.dart';

class Message {
  String id;
  String content;
  DateTime? sentAt;
  String? status;
  String matchId;
  String senderId;
  Matching? match;
  Member? sender;

  Message({
    required this.id,
    required this.content,
    this.sentAt,
    this.status,
    required this.matchId,
    required this.senderId,
    this.match,
    this.sender,
  });

  // Method to create Message object from JSON
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      content: json['content'],
      sentAt: json['sentAt'] == null
          ? null
          : DateTime.parse(json['sentAt']),
      status: json['status'],
      matchId: json['matchId'],
      senderId: json['senderId'],
      match: json['match'] == null
          ? null
          : Matching.fromJson(json['match']),
      sender: json['sender'] == null
          ? null
          : Member.fromJson(json['sender']),
    );
  }

  // Method to convert Message object to JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'content': content,
        'sentAt': sentAt?.toIso8601String(),
        'status': status,
        'matchId': matchId,
        'senderId': senderId,
        'match': match?.toJson(),
        'sender': sender?.toJson(),
      };
}
