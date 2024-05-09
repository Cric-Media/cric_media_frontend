class Player {
  String? id;
  String? name;
  String? location;
  String? role;
  String? age;
  String? additionalInfo;
  String? imageUrl;
  List<String>? admins;
  // Stats? stats;
  Stats? t20Stats;
  Stats? odiStats;
  Stats? lastPerformance;

  Player({
    this.name,
    this.id,
    this.location,
    this.role,
    this.age,
    this.additionalInfo,
    this.imageUrl,
    this.admins,
    // this.stats,
    this.t20Stats,
    this.odiStats,
    this.lastPerformance,
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
    // stats = json['stats'] != null ? Stats.fromJson(json['stats']) : null;
    t20Stats =
        json['t20Stats'] != null ? Stats.fromJson(json['t20Stats']) : null;
    odiStats =
        json['odiStats'] != null ? Stats.fromJson(json['odiStats']) : null;
    lastPerformance = json['lastPerformance'] != null
        ? Stats.fromJson(json['lastPerformance'])
        : null;
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
    // if (stats != null) {
    //   data['stats'] = stats!.toJson();
    // }
    if (t20Stats != null) {
      data['t20Stats'] = t20Stats!.toJson();
    }
    if (odiStats != null) {
      data['odiStats'] = odiStats!.toJson();
    }
    if (lastPerformance != null) {
      data['lastPerformance'] = lastPerformance!.toJson();
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
        // other.stats == stats;
        other.t20Stats == t20Stats &&
        other.odiStats == odiStats &&
        other.lastPerformance == lastPerformance;
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
        // stats.hashCode;
        t20Stats.hashCode ^
        odiStats.hashCode ^
        lastPerformance.hashCode;
  }
}

class Stats {
  int? sixes;
  int? fours;
  int? wickets;
  num? runs, catches, balls, fifties, hundreds, innings, highestScore, matches;

  Stats({
    this.sixes,
    this.fours,
    this.wickets,
    this.runs,
    this.catches,
    this.balls,
    this.fifties,
    this.hundreds,
    this.innings,
    this.highestScore,
    this.matches,
  });

  Stats.fromJson(Map<String, dynamic> json) {
    sixes = json['sixes'];
    fours = json['fours'];
    wickets = json['wickets'];
    runs = json['runs'];
    catches = json['catches'];
    balls = json['balls'];
    fifties = json['fifties'];
    hundreds = json['hundreds'];
    innings = json['innings'];
    highestScore = json['highestScore'];
    matches = json['matches'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sixes'] = sixes;
    data['fours'] = fours;
    data['wickets'] = wickets;
    data['runs'] = runs;
    data['catches'] = catches;
    data['balls'] = balls;
    data['fifties'] = fifties;
    data['hundreds'] = hundreds;
    data['innings'] = innings;
    data['highestScore'] = highestScore;
    data['matches'] = matches;
    return data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Stats &&
        other.sixes == sixes &&
        other.fours == fours &&
        other.wickets == wickets &&
        other.runs == runs &&
        other.catches == catches &&
        other.balls == balls &&
        other.fifties == fifties &&
        other.hundreds == hundreds &&
        other.innings == innings &&
        other.highestScore == highestScore &&
        other.matches == matches;
  }

  @override
  int get hashCode {
    return sixes.hashCode ^
        fours.hashCode ^
        wickets.hashCode ^
        runs.hashCode ^
        catches.hashCode ^
        balls.hashCode ^
        fifties.hashCode ^
        hundreds.hashCode ^
        innings.hashCode ^
        highestScore.hashCode ^
        matches.hashCode;
  }
}
