import 'package:flutter_chats_app/models/Account.dart';
import 'package:flutter_chats_app/models/Hobby.dart';
import 'package:flutter_chats_app/models/Major.dart';
import 'package:flutter_chats_app/models/Matching.dart';
import 'package:flutter_chats_app/models/MemberPackage.dart';
import 'package:flutter_chats_app/models/Message.dart';
import 'package:flutter_chats_app/models/University.dart';
import 'package:flutter_chats_app/models/Picture.dart';
class Member {
  final String id;
  final String? fullname;
  final String? introduce;
  final DateTime? dob;
  final bool? gender;
  final String? address;
  final int? surplus;
  final String? status;
  final String accountId;
  final String universityId;
  final String majorId;
  final Account? account;
  final Major? major;
  final List<Matching> matchingFirstMembers;
  final List<Matching> matchingSecondMembers;
  final List<MemberPackage> memberPackages;
  final List<Message> messages;
  final List<Picture> pictures;
  final University? university;
  final List<Hobby> hobbies;

  Member({
    required this.id,
    this.fullname,
    this.introduce,
    this.dob,
    this.gender,
    this.address,
    this.surplus,
    this.status,
    required this.accountId,
    required this.universityId,
    required this.majorId,
    this.account,
    this.major,
    this.matchingFirstMembers = const [],
    this.matchingSecondMembers = const [],
    this.memberPackages = const [],
    this.messages = const [],
    this.pictures = const [],
    this.university,
    this.hobbies = const [],
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'] ?? '',
      fullname: json['fullname'],
      introduce: json['introduce'],
      dob: json['dob'] != null ? DateTime.tryParse(json['dob']) : null,
      gender: json['gender'],
      address: json['address'],
      surplus: json['surplus'],
      status: json['status'],
      accountId: json['account-id'] ?? '',
      universityId: json['university-id'] ?? '',
      majorId: json['major-id'] ?? '',
      account: json['account'] != null ? Account.fromJson(json['account'] as Map<String, dynamic>) : null,
      major: json['major'] != null ? Major.fromJson(json['major'] as Map<String, dynamic>) : null,
      matchingFirstMembers: (json['matching-first-members'] as List<dynamic>? ?? [])
          .map((item) => Matching.fromJson(item as Map<String, dynamic>))
          .toList(),
      matchingSecondMembers: (json['matching-second-members'] as List<dynamic>? ?? [])
          .map((item) => Matching.fromJson(item as Map<String, dynamic>))
          .toList(),
      memberPackages: (json['member-packages'] as List<dynamic>? ?? [])
          .map((item) => MemberPackage.fromJson(item as Map<String, dynamic>))
          .toList(),
      messages: (json['messages'] as List<dynamic>? ?? [])
          .map((item) => Message.fromJson(item as Map<String, dynamic>))
          .toList(),
      pictures: (json['pictures'] as List<dynamic>? ?? [])
          .map((item) => Picture.fromJson(item as Map<String, dynamic>))
          .toList(),
      university: json['university'] != null ? University.fromJson(json['university'] as Map<String, dynamic>) : null,
      hobbies: (json['hobbies'] as List<dynamic>? ?? [])
          .map((item) => Hobby.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullname': fullname,
      'introduce': introduce,
      'dob': dob?.toIso8601String(),
      'gender': gender,
      'address': address,
      'surplus': surplus,
      'status': status,
      'account-id': accountId,
      'university-id': universityId,
      'major-id': majorId,
      'account': account?.toJson(),
      'major': major?.toJson(),
      'matching-first-members': matchingFirstMembers.map((e) => e.toJson()).toList(),
      'matching-second-members': matchingSecondMembers.map((e) => e.toJson()).toList(),
      'member-packages': memberPackages.map((e) => e.toJson()).toList(),
      'messages': messages.map((e) => e.toJson()).toList(),
      'pictures': pictures.map((e) => e.toJson()).toList(),
      'university': university?.toJson(),
      'hobbies': hobbies.map((e) => e.toJson()).toList(),
    };
  }
}
