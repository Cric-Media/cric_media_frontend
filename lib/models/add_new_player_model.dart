// ignore_for_file: non_constant_identifier_names

class AddNewPlayerModel {
  String? name;
  int created_by; // This field is required
  String? type;
  int? age;
  String additional_information;
  String? location;
  String
      image; // Assuming this is a base64 string without the "data:image/png;base64," part

  AddNewPlayerModel({
    this.name,
    required this.created_by,
    this.type,
    this.age,
    this.additional_information = "abc",
    this.location,
    required this.image,
  });

  // Method to convert an ItemModel instance to a Map (useful for JSON encoding)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'created_by': created_by,
      'type': type,
      'age': age,
      'additional_information': additional_information,
      'location': location,
      'image': image,
    };
  }

  // Factory constructor to create an ItemModel instance from a Map (useful for JSON decoding)
  factory AddNewPlayerModel.fromJson(Map<String, dynamic> json) {
    return AddNewPlayerModel(
      name: json['name'],
      created_by: json['created_by'],
      type: json['type'],
      age: json['age'],
      additional_information: json['additional_information'] ?? "abc",
      location: json['location'],
      image: json['image'],
    );
  }
}
