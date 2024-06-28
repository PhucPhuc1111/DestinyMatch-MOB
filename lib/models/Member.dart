import 'dart:convert';
import 'dart:ui';

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
  final Account account;
  final Major major;
  final List<Matching> matchingFirstMembers;
  final List<Matching> matchingSecondMembers;
  final List<MemberPackage> memberPackages;
  final List<Message> messages;
  final List<Picture> pictures;
  final University university;
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
    required this.account,
    required this.major,
    required this.matchingFirstMembers,
    required this.matchingSecondMembers,
    required this.memberPackages,
    required this.messages,
    required this.pictures,
    required this.university,
    required this.hobbies,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      fullname: json['fullname'],
      introduce: json['introduce'],
      dob: json['dob'] != null ? DateTime.parse(json['dob']) : null,
      gender: json['gender'],
      address: json['address'],
      surplus: json['surplus'],
      status: json['status'],
      accountId: json['accountId'],
      universityId: json['universityId'],
      majorId: json['majorId'],
      account: Account.fromJson(json['account']),
      major: Major.fromJson(json['major']),
      matchingFirstMembers: (json['matchingFirstMembers'] as List)
          .map((i) => Matching.fromJson(i))
          .toList(),
      matchingSecondMembers: (json['matchingSecondMembers'] as List)
          .map((i) => Matching.fromJson(i))
          .toList(),
      memberPackages: (json['memberPackages'] as List)
          .map((i) => MemberPackage.fromJson(i))
          .toList(),
      messages: (json['messages'] as List).map((i) => Message.fromJson(i)).toList(),
      pictures: (json['pictures'] as List).map((i) => Picture.fromJson(i)).toList(),
      university: University.fromJson(json['university']),
      hobbies: (json['hobbies'] as List).map((i) => Hobby.fromJson(i)).toList(),
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
      'accountId': accountId,
      'universityId': universityId,
      'majorId': majorId,
      'account': account.toJson(),
      'major': major.toJson(),
      'matchingFirstMembers': matchingFirstMembers.map((e) => e.toJson()).toList(),
      'matchingSecondMembers': matchingSecondMembers.map((e) => e.toJson()).toList(),
      'memberPackages': memberPackages.map((e) => e.toJson()).toList(),
      'messages': messages.map((e) => e.toJson()).toList(),
      'pictures': pictures.map((e) => e.toJson()).toList(),
      'university': university.toJson(),
      'hobbies': hobbies.map((e) => e.toJson()).toList(),
    };
  }
}
