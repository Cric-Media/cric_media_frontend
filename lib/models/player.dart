class Player {
  String? id;
  String? name;
  String? location;
  String? role;
  String? age;
  String? additionalInfo;
  List<String>? admins;
  Stats? stats;

  Player({
    this.name,
    this.id,
    this.location,
    this.role,
    this.age,
    this.additionalInfo,
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
    admins = json['admins'].cast<String>();
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
    data['admins'] = admins;
    if (stats != null) {
      data['stats'] = stats!.toJson();
    }
    return data;
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
}
