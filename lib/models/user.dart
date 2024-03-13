class User {
  String? id, name, email, imageUrl, phoneNumber, password, accessToken;
  User({
    this.id,
    this.name,
    this.email,
    this.imageUrl,
    this.phoneNumber,
    this.password,
    this.accessToken,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      imageUrl: json['imageUrl'],
      phoneNumber: json['phoneNumber'],
      accessToken: json['accessToken'],
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
