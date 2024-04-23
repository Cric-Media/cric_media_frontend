import 'package:cricket_app/models/player.dart';

class ScoreCard {
  String? sId;
  String? match;
  int? innings;
  BattingTeam? battingTeam;
  BattingTeam? bowlingTeam;
  List<Batsmen>? batsmen;
  List<Bowlers>? bowlers;
  int? iV;

  ScoreCard(
      {this.sId,
      this.match,
      this.innings,
      this.battingTeam,
      this.bowlingTeam,
      this.batsmen,
      this.bowlers,
      this.iV});

  ScoreCard.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    match = json['match'];
    innings = json['innings'];
    battingTeam = json['battingTeam'] != null
        ? BattingTeam.fromJson(json['battingTeam'])
        : null;
    bowlingTeam = json['bowlingTeam'] != null
        ? BattingTeam.fromJson(json['bowlingTeam'])
        : null;
    if (json['batsmen'] != null) {
      batsmen = <Batsmen>[];
      json['batsmen'].forEach((v) {
        batsmen!.add(Batsmen.fromJson(v));
      });
    }
    if (json['bowlers'] != null) {
      bowlers = <Bowlers>[];
      json['bowlers'].forEach((v) {
        bowlers!.add(Bowlers.fromJson(v));
      });
    }
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['match'] = match;
    data['innings'] = innings;
    if (battingTeam != null) {
      data['battingTeam'] = battingTeam!.toJson();
    }
    if (bowlingTeam != null) {
      data['bowlingTeam'] = bowlingTeam!.toJson();
    }
    if (batsmen != null) {
      data['batsmen'] = batsmen!.map((v) => v.toJson()).toList();
    }
    if (bowlers != null) {
      data['bowlers'] = bowlers!.map((v) => v.toJson()).toList();
    }
    data['__v'] = iV;
    return data;
  }
}

class BattingTeam {
  String? name;
  String? image;

  BattingTeam({this.name, this.image});

  BattingTeam.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
    return data;
  }
}

class Batsmen {
  Player? player;
  num? runs;
  num? ballsFaced;
  num? fours;
  num? sixes;
  num? strikeRate;
  String? sId;

  Batsmen(
      {this.player,
      this.runs,
      this.ballsFaced,
      this.fours,
      this.sixes,
      this.strikeRate,
      this.sId});

  Batsmen.fromJson(Map<String, dynamic> json) {
    player = json['player'] != null ? Player.fromJson(json['player']) : null;
    runs = json['runs'];
    ballsFaced = json['ballsFaced'];
    fours = json['fours'];
    sixes = json['sixes'];
    strikeRate = json['strikeRate'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (player != null) {
      data['player'] = player!.toJson();
    }
    data['runs'] = runs;
    data['ballsFaced'] = ballsFaced;
    data['fours'] = fours;
    data['sixes'] = sixes;
    data['strikeRate'] = strikeRate;
    data['_id'] = sId;
    return data;
  }
}

class Bowlers {
  Player? player;
  num? overs;
  num? maidens;
  num? runsGiven;
  num? wickets;
  num? economy;
  String? sId;

  Bowlers(
      {this.player,
      this.overs,
      this.maidens,
      this.runsGiven,
      this.wickets,
      this.economy,
      this.sId});

  Bowlers.fromJson(Map<String, dynamic> json) {
    player = json['player'] != null ? Player.fromJson(json['player']) : null;
    overs = json['overs'];
    maidens = json['maidens'];
    runsGiven = json['runsGiven'];
    wickets = json['wickets'];
    economy = json['economy'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (player != null) {
      data['player'] = player!.toJson();
    }
    data['overs'] = overs;
    data['maidens'] = maidens;
    data['runsGiven'] = runsGiven;
    data['wickets'] = wickets;
    data['economy'] = economy;
    data['_id'] = sId;
    return data;
  }
}
