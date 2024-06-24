import 'package:destinymatch/models/Member.dart';

import 'conversation.dart';

class Message {
  String id;
  String content;
  DateTime? sentAt;
  String? status;
  String conversationId;
  String senderId;
  Conversation? conversation;
  Member? sender;

  Message({
    required this.id,
    required this.content,
    this.sentAt,
    this.status,
    required this.conversationId,
    required this.senderId,
    this.conversation,
    this.sender,
  });

  // Phương thức từ JSON
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      content: json['content'],
      sentAt: json['sentAt'] != null ? DateTime.parse(json['sentAt']) : null,
      status: json['status'],
      conversationId: json['conversationId'],
      senderId: json['senderId'],
      conversation: json['conversation'] != null
          ? Conversation.fromJson(json['conversation'])
          : null,
      sender: json['sender'] != null ? Member.fromJson(json['sender']) : null,
    );
  }

  // Phương thức to JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'content': content,
        'sentAt': sentAt?.toIso8601String(),
        'status': status,
        'conversationId': conversationId,
        'senderId': senderId,
        'conversation': conversation?.toJson(),
        'sender': sender?.toJson(),
      };
}
