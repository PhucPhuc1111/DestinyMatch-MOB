import 'package:destinymatch/models/Member.dart';

class MatchRequest {
  String id;
  DateTime? createAt;
  String? status;
  String fromId;
  String toId;
  Member? from;
  Member? to;

  MatchRequest({
    required this.id,
    this.createAt,
    this.status,
    required this.fromId,
    required this.toId,
    this.from,
    this.to,
  });

  // Method to create MatchRequest object from JSON
  factory MatchRequest.fromJson(Map<String, dynamic> json) {
    return MatchRequest(
      id: json['id'],
      createAt: json['createAt'] != null
          ? DateTime.parse(json['createAt'])
          : null, // Example assuming date is in ISO 8601 format
      status: json['status'],
      fromId: json['fromId'],
      toId: json['toId'],
      from: json['from'] != null ? Member.fromJson(json['from']) : null,
      to: json['to'] != null ? Member.fromJson(json['to']) : null,
    );
  }

  // Method to convert MatchRequest object to JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'createAt': createAt?.toIso8601String(), // Convert DateTime to ISO 8601 format
        'status': status,
        'fromId': fromId,
        'toId': toId,
        'from': from?.toJson(),
        'to': to?.toJson(),
      };
}
