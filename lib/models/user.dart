class User {
  String? id,
      name,
      email,
      imageUrl,
      phoneNumber,
      password,
      accessToken,
      profileImage;
  User({
    this.id,
    this.name,
    this.email,
    this.imageUrl,
    this.phoneNumber,
    this.password,
    this.accessToken,
    this.profileImage,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['fullname'],
      email: json['email'],
      imageUrl: json['imageUrl'],
      phoneNumber: json['Phone'],
      accessToken: json['accessToken'],
      profileImage: json['ProfileImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
      'phoneNumber': phoneNumber,
      'accessToken': accessToken,
    };
  }
}
