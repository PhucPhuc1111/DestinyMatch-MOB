
class Message {
  final String id;
  final String content;
  final DateTime? sentAt;
  final String? status;
  final String matchId;
  final String senderId;

  Message({
    required this.id,
    required this.content,
    this.sentAt,
    this.status,
    required this.matchId,
    required this.senderId,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] as String,
      content: json['content'] ?? '', // Sử dụng giá trị mặc định nếu null
      sentAt: json['sent-at'] != null ? DateTime.parse(json['sent-at']) : null,
      status: json['status'] ?? '',
      matchId: json['match-id'] as String,
      senderId: json['sender-id'] as String,
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
      };
}
