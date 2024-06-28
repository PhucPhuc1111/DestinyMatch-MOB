import 'package:flutter_chats_app/models/MemberPackage.dart';

class Package {
  String id;
  String? code;
  String? name;
  String? description;
  int? price;
  String? status;
  List<MemberPackage> memberPackages;

  Package({
    required this.id,
    this.code,
    this.name,
    this.description,
    this.price,
    this.status,
    this.memberPackages = const [], // Initialize with an empty list
  });

  // Method to create Package object from JSON
  factory Package.fromJson(Map<String, dynamic> json) {
    return Package(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      status: json['status'],
      memberPackages: List<MemberPackage>.from(
          json['memberPackages'].map((x) => MemberPackage.fromJson(x))),
    );
  }

  // Method to convert Package object to JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'code': code,
        'name': name,
        'description': description,
        'price': price,
        'status': status,
        'memberPackages':
            List<dynamic>.from(memberPackages.map((x) => x.toJson())),
      };
}
