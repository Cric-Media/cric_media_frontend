class GetAlllTeamModel {
  int id;
  String image;
  String location;
  String name;
  int createdBy;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  CreatedByUser createdByUser;

  GetAlllTeamModel({
    required this.id,
    required this.image,
    required this.location,
    required this.name,
    required this.createdBy,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.createdByUser,
  });

  factory GetAlllTeamModel.fromJson(Map<String, dynamic> json) {
    return GetAlllTeamModel(
      id: json['id'],
      image: json['image'],
      location: json['location'],
      name: json['name'],
      createdBy: json['created_by'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      createdByUser: CreatedByUser.fromJson(json['created_by_user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'location': location,
      'name': name,
      'created_by': createdBy,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'created_by_user': createdByUser.toJson(),
    };
  }
}

class CreatedByUser {
  int id;
  String name;
  String email;
  String phone;
  DateTime createdAt;
  DateTime updatedAt;

  CreatedByUser({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CreatedByUser.fromJson(Map<String, dynamic> json) {
    return CreatedByUser(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
