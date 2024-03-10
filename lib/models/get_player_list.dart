class getPlayerList {
  int? id;
  String? image;
  String? location;
  String? name;
  int? age;
  String? type;
  String? additional_information;
  int? createdBy;

  

  getPlayerList({
    this.id,
    this.image,
    this.location,
    this.name,
    this.age,
    this.type,
    this.additional_information,
    this.createdBy,
   
  });

  factory getPlayerList.fromJson(Map<String, dynamic> json) => getPlayerList(
        id: json['id'] as int?,
        image: json['image'] as String?,
        location: json['location'] as String?,
        name: json['name'] as String?,
        age: json['age'] as int?,
        type: json['type'] as String?,
        additional_information: json['additional_information'] as String?,
        createdBy: json['created_by'] as int?,
       
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'image': image,
        'location': location,
        'name': name,
        'age': age,
        'type': type,
        'additional_information': additional_information,
        'created_by': createdBy,
      
      };
}
