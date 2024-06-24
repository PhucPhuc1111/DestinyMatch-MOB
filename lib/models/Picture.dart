class Picture {
  String id;
  String? urlPath;
  bool? isAvatar;
  String? status;
  String memberId;

  Picture({
    required this.id,
    this.urlPath,
    this.isAvatar,
    this.status,
    required this.memberId,
  });

  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
      id: json['id'],
      urlPath: json['urlPath'],
      isAvatar: json['isAvatar'],
      status: json['status'],
      memberId: json['memberId'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'urlPath': urlPath,
    'isAvatar': isAvatar,
    'status': status,
    'memberId': memberId,
  };
}
