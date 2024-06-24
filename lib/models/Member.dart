import 'package:destinymatch/models/Account.dart';
import 'package:destinymatch/models/Conversation.dart';
import 'package:destinymatch/models/Hobby.dart';
import 'package:destinymatch/models/Major.dart';
import 'package:destinymatch/models/MatchRequest.dart';
import 'package:destinymatch/models/MemberPackage.dart';
import 'package:destinymatch/models/Message.dart';
import 'package:destinymatch/models/University.dart';
import 'package:destinymatch/models/Picture.dart';
import 'package:flutter/material.dart';

class Member {
  String id;
  String? fullname;
  String? introduce;
  DateTime? dob;
  bool? gender;
  String? address;
  int? surplus;
  String? status;
  String accountId;
  String universityId;
  String majorId;
  Account? account;
  List<Conversation> conversationFirstMembers;
  List<Conversation> conversationSecondMembers;
  List<Feedback> feedbacks;
  Major? major;
  List<MatchRequest> matchRequestFroms;
  List<MatchRequest> matchRequestTos;
  List<MemberPackage> memberPackages;
  List<Message> messages;
  List<Picture> pictures;
  University? university;
  List<Hobby> hobbies;

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
    this.conversationFirstMembers = const [],
    this.conversationSecondMembers = const [],
    this.feedbacks = const [],
    this.major,
    this.matchRequestFroms = const [],
    this.matchRequestTos = const [],
    this.memberPackages = const [],
    this.messages = const [],
    this.pictures = const [],
    this.university,
    this.hobbies = const [],
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
      account: json['account'] != null ? Account.fromJson(json['account']) : null,
      conversationFirstMembers: List<Conversation>.from(json['conversationFirstMembers'].map((x) => Conversation.fromJson(x))),
      conversationSecondMembers: List<Conversation>.from(json['conversationSecondMembers'].map((x) => Conversation.fromJson(x))),
      major: json['major'] != null ? Major.fromJson(json['major']) : null,
      matchRequestFroms: List<MatchRequest>.from(json['matchRequestFroms'].map((x) => MatchRequest.fromJson(x))),
      matchRequestTos: List<MatchRequest>.from(json['matchRequestTos'].map((x) => MatchRequest.fromJson(x))),
      memberPackages: List<MemberPackage>.from(json['memberPackages'].map((x) => MemberPackage.fromJson(x))),
      messages: List<Message>.from(json['messages'].map((x) => Message.fromJson(x))),
      pictures: List<Picture>.from(json['pictures'].map((x) => Picture.fromJson(x))),
      university: json['university'] != null ? University.fromJson(json['university']) : null,
      hobbies: List<Hobby>.from(json['hobbies'].map((x) => Hobby.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'fullname': fullname,
    'introduce': introduce,
    'dob': dob?.toIso8601String(), // Convert DateTime to ISO 8601 format
    'gender': gender,
    'address': address,
    'surplus': surplus,
    'status': status,
    'accountId': accountId,
    'universityId': universityId,
    'majorId': majorId,
    'account': account?.toJson(),
    'conversationFirstMembers': List<dynamic>.from(conversationFirstMembers.map((x) => x.toJson())),
    'conversationSecondMembers': List<dynamic>.from(conversationSecondMembers.map((x) => x.toJson())),
    'major': major?.toJson(),
    'matchRequestFroms': List<dynamic>.from(matchRequestFroms.map((x) => x.toJson())),
    'matchRequestTos': List<dynamic>.from(matchRequestTos.map((x) => x.toJson())),
    'memberPackages': List<dynamic>.from(memberPackages.map((x) => x.toJson())),
    'messages': List<dynamic>.from(messages.map((x) => x.toJson())),
    'pictures': List<dynamic>.from(pictures.map((x) => x.toJson())),
    'university': university?.toJson(),
    'hobbies': List<dynamic>.from(hobbies.map((x) => x.toJson())),
  };

  static Member fromJsonWithPictures(Map<String, dynamic> json, List<Picture> pictures) {
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
      account: json['account'] != null ? Account.fromJson(json['account']) : null,
      conversationFirstMembers: List<Conversation>.from(json['conversationFirstMembers'].map((x) => Conversation.fromJson(x))),
      conversationSecondMembers: List<Conversation>.from(json['conversationSecondMembers'].map((x) => Conversation.fromJson(x))),
      major: json['major'] != null ? Major.fromJson(json['major']) : null,
      matchRequestFroms: List<MatchRequest>.from(json['matchRequestFroms'].map((x) => MatchRequest.fromJson(x))),
      matchRequestTos: List<MatchRequest>.from(json['matchRequestTos'].map((x) => MatchRequest.fromJson(x))),
      memberPackages: List<MemberPackage>.from(json['memberPackages'].map((x) => MemberPackage.fromJson(x))),
      messages: List<Message>.from(json['messages'].map((x) => Message.fromJson(x))),
      pictures: pictures,
      university: json['university'] != null ? University.fromJson(json['university']) : null,
      hobbies: List<Hobby>.from(json['hobbies'].map((x) => Hobby.fromJson(x))),
    );
  }
}
