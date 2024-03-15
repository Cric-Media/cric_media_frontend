class Player {
  String? sId;
  String? name;
  String? location;
  String? role;
  int? age;
  String? additionalInfo;
  List<String>? admins;

  Player(
      {this.sId,
      this.name,
      this.location,
      this.role,
      this.age,
      this.additionalInfo,
      this.admins});

  Player.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    location = json['location'];
    role = json['role'];
    age = json['age'];
    additionalInfo = json['additionalInfo'];
    admins = json['admin'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['location'] = location;
    data['role'] = role;
    data['age'] = age;
    data['additionalInfo'] = additionalInfo;
    data['admin'] = admins;
    return data;
  }
}
