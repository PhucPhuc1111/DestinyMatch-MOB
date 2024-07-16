class MemberRequest {
  final String? fullname;
  final String? introduce;
  final String? dob; // Giữ nguyên như là String
  final bool? gender;
  final String? address;
  final int? surplus;
  final String? status;
  final String accountId; // Đảm bảo là không nullable
  final String universityId; // Đảm bảo là không nullable
  final String majorId; // Đảm bảo là không nullable

  MemberRequest({
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
  });

  Map<String, dynamic> toJson() {
    return {
      'fullname': fullname,
      'introduce': introduce,
      'dob': dob,
      'gender': gender,
      'address': address,
      'surplus': surplus,
      'status': status,
      'account-id': accountId,
      'university-id': universityId,
      'major-id': majorId,
    };
  }

  factory MemberRequest.fromJson(Map<String, dynamic> json) {
    return MemberRequest(
      fullname: json['fullname'],
      introduce: json['introduce'],
      dob: json['dob'],
      gender: json['gender'],
      address: json['address'],
      surplus: json['surplus'],
      status: json['status'],
      accountId: json['account-id'],
      universityId: json['university-id'],
      majorId: json['major-id'],
    );
  }
}
