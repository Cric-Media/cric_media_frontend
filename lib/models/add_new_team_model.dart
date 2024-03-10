class AddNewTeamModel {
  int id;
  String name;
  int createdBy;
  String location;
  String image;

  AddNewTeamModel({
    required this.id,
    required this.name,
    required this.createdBy,
    required this.location,
    required this.image,
  });

  factory AddNewTeamModel.fromJson(Map<String, dynamic> json) {
    return AddNewTeamModel(
      id: json['id'] as int,
      name: json['name'] as String,
      createdBy: json['created_by'] as int,
      location: json['location'] as String,
      image: json['image'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'created_by': createdBy,
      'location': location,
      'image': image,
    };
  }
}
