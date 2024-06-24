import 'package:destinymatch/models/Member.dart';
import 'package:destinymatch/models/Package.dart';

class MemberPackage {
  String id;
  DateTime? startDate;
  DateTime? endDate;
  String? status;
  String memberId;
  String packageId;
  Member? member;
  Package? package;

  MemberPackage({
    required this.id,
    this.startDate,
    this.endDate,
    this.status,
    required this.memberId,
    required this.packageId,
    this.member,
    this.package,
  });

  // Method to create MemberPackage object from JSON
  factory MemberPackage.fromJson(Map<String, dynamic> json) {
    return MemberPackage(
      id: json['id'],
      startDate: json['startDate'] != null
          ? DateTime.parse(json['startDate'])
          : null, // Example assuming date is in ISO 8601 format
      endDate: json['endDate'] != null
          ? DateTime.parse(json['endDate'])
          : null, // Example assuming date is in ISO 8601 format
      status: json['status'],
      memberId: json['memberId'],
      packageId: json['packageId'],
      member: json['member'] != null ? Member.fromJson(json['member']) : null,
      package: json['package'] != null ? Package.fromJson(json['package']) : null,
    );
  }

  // Method to convert MemberPackage object to JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'startDate': startDate?.toIso8601String(), // Convert DateTime to ISO 8601 format
        'endDate': endDate?.toIso8601String(), // Convert DateTime to ISO 8601 format
        'status': status,
        'memberId': memberId,
        'packageId': packageId,
        'member': member?.toJson(),
        'package': package?.toJson(),
      };
}
