class UserRegisterModel {
  String email;
  String username;
  String password;
  String phone;

  UserRegisterModel({
    required this.email,
    required this.username,
    required this.password,
    required this.phone,
  });

  // Optionally, create a method to convert a User object to a map, which can be useful for JSON serialization/deserialization or storing the data in a database.
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'username': username,
      'password': password, // Be cautious with password handling
      'phoneNumber': phone,
    };
  }

  // Factory constructor to create a User from a map, useful for deserialization
  factory UserRegisterModel.fromMap(Map<String, dynamic> map) {
    return UserRegisterModel(
      email: map['email'] ?? '',
      username: map['username'] ?? '',
      password: map['password'] ?? '', // Ensure you handle passwords securely
      phone: map['phone'] ?? '',
    );
  }
}
