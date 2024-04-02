class Player {
  String? id;
  String? name;
  String? location;
  String? role;
  String? age;
  String? additionalInfo;
  String? imageUrl;
  List<String>? admins;
  Stats? stats;

  Player({
    this.name,
    this.id,
    this.location,
    this.role,
    this.age,
    this.additionalInfo,
    this.imageUrl,
    this.admins,
    this.stats,
  });

  Player.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    location = json['location'];
    role = json['role'];
    age = json['age'];
    additionalInfo = json['additionalInfo'];
    imageUrl = json['Image'];
    admins = json['admins']?.cast<String>();
    stats = json['stats'] != null ? Stats.fromJson(json['stats']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    data['location'] = location;
    data['role'] = role;
    data['age'] = age;
    data['additionalInfo'] = additionalInfo;
    data['Image'] = imageUrl;
    data['admins'] = admins;
    if (stats != null) {
      data['stats'] = stats!.toJson();
    }
    return data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Player &&
        other.id == id &&
        other.name == name &&
        other.location == location &&
        other.role == role &&
        other.age == age &&
        other.additionalInfo == additionalInfo &&
        other.imageUrl == imageUrl &&
        other.admins == admins &&
        other.stats == stats;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        location.hashCode ^
        role.hashCode ^
        age.hashCode ^
        additionalInfo.hashCode ^
        imageUrl.hashCode ^
        admins.hashCode ^
        stats.hashCode;
  }
}

class Stats {
  int? sixes;
  int? fours;
  int? wickets;

  Stats({this.sixes, this.fours, this.wickets});

  Stats.fromJson(Map<String, dynamic> json) {
    sixes = json['sixes'];
    fours = json['fours'];
    wickets = json['wickets'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sixes'] = sixes;
    data['fours'] = fours;
    data['wickets'] = wickets;
    return data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Stats &&
        other.sixes == sixes &&
        other.fours == fours &&
        other.wickets == wickets;
  }

  @override
  int get hashCode {
    return sixes.hashCode ^ fours.hashCode ^ wickets.hashCode;
  }
}
