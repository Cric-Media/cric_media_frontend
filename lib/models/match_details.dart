import 'package:cricket_app/models/ball.dart';
import 'package:cricket_app/models/player.dart';
import 'package:cricket_app/models/team.dart';

class MatchDetails {
  String? admin;
  Team? team1;
  Team? team2;
  String? matchType;
  String? ballType;
  String? pitchType;
  int? numberOfOvers;
  int? oversPerBowler;
  String? cityOrTown;
  String? ground;
  String? matchDateTime;
  String? whoWinsTheToss;
  String? tossDetails;
  int? matchStatus;
  bool? team1Batting;
  bool? team2Batting;
  bool? team1toss;
  bool? team2toss;
  Player? manOfTheMatch, striker, nonStriker, openingBowler;
  int? team1Score;
  int? team2Score;
  int? team1Overs;
  int? team2Overs;
  int? team1Balls;
  int? team2Balls;
  int? team1Outs;
  int? team2Outs;
  List<Player>? squad1;
  List<Player>? squad2;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;
  int? currentInning;
  List<dynamic>? innings;
  List<PlayerStats>? playerStats;
  List<BowlerStats>? bowlerStats;
  CurrentOver? currentOver;
  List<Over>? overs;
  List<dynamic>? scorecard;

  MatchDetails({
    this.admin,
    this.team1,
    this.team2,
    this.matchType,
    this.ballType,
    this.pitchType,
    this.numberOfOvers,
    this.oversPerBowler,
    this.cityOrTown,
    this.ground,
    this.matchDateTime,
    this.whoWinsTheToss,
    this.tossDetails,
    this.matchStatus,
    this.team1Batting,
    this.team2Batting,
    this.team1toss,
    this.team2toss,
    this.manOfTheMatch,
    this.team1Score,
    this.team2Score,
    this.team1Overs,
    this.team2Overs,
    this.team1Balls,
    this.team2Balls,
    this.team1Outs,
    this.team2Outs,
    this.squad1,
    this.squad2,
    this.sId,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.currentInning,
    this.innings,
    this.playerStats,
    this.bowlerStats,
    this.currentOver,
    this.overs,
    this.scorecard,
  });

  MatchDetails.fromJson(Map<String, dynamic> json) {
    admin = json['admin'];
    team1 = json['team1'] == null ? null : Team.fromJson(json['team1']);
    team2 = json['team2'] == null ? null : Team.fromJson(json['team2']);
    matchType = json['matchType'];
    ballType = json['ballType'];
    pitchType = json['pitchType'];
    numberOfOvers = json['numberOfOvers'];
    oversPerBowler = json['oversPerBowler'];
    cityOrTown = json['cityOrTown'];
    ground = json['ground'];
    matchDateTime = json['matchDateTime'];
    whoWinsTheToss = json['whoWinsTheToss'];
    tossDetails = json['tossDetails'];
    matchStatus = json['matchStatus'];
    team1Batting = json['team1Batting'];
    team2Batting = json['team2Batting'];
    team1toss = json['team1toss'];
    team2toss = json['team2toss'];
    manOfTheMatch = json['manOfTheMatch'] != null
        ? Player.fromJson(json['manOfTheMatch'])
        : null;
    striker = json['striker'] != null ? Player.fromJson(json['striker']) : null;
    nonStriker =
        json['nonStriker'] != null ? Player.fromJson(json['nonStriker']) : null;
    openingBowler = json['openingBowler'] != null
        ? Player.fromJson(json['openingBowler'])
        : null;
    team1Score = json['team1Score'];
    team2Score = json['team2Score'];
    team1Overs = json['team1Overs'];
    team2Overs = json['team2Overs'];
    team1Balls = json['team1Balls'];
    team2Balls = json['team2Balls'];
    team1Outs = json['team1Outs'];
    team2Outs = json['team2Outs'];
    if (json['squad1'] != null) {
      squad1 = <Player>[];
      json['squad1'].forEach((v) {
        squad1!.add(Player.fromJson(v));
      });
    }
    if (json['squad2'] != null) {
      squad2 = <Player>[];
      json['squad2'].forEach((v) {
        squad2!.add(Player.fromJson(v));
      });
    }
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    currentInning = json['currentInning'];
    innings = json['innings'];
    playerStats = json['playerStats'] != null
        ? (json['playerStats'] as List)
            .map((i) => PlayerStats.fromJson(i))
            .toList()
        : null;
    bowlerStats = json['bowlerStats'] != null
        ? (json['bowlerStats'] as List)
            .map((i) => BowlerStats.fromJson(i))
            .toList()
        : null;
    currentOver = json['currentOver'] != null
        ? CurrentOver.fromJson(json['currentOver'])
        : null;
    // overs = json['overs'];
    if (json['overs'] != null) {
      overs = <Over>[];
      json['overs'].forEach((o) {
        overs!.add(Over.fromJson(o));
      });
    }
    scorecard = json['scorecard'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['admin'] = admin;
    data['team1'] = team1;
    data['team2'] = team2;
    data['matchType'] = matchType;
    data['ballType'] = ballType;
    data['pitchType'] = pitchType;
    data['numberOfOvers'] = numberOfOvers;
    data['oversPerBowler'] = oversPerBowler;
    data['cityOrTown'] = cityOrTown;
    data['ground'] = ground;
    data['matchDateTime'] = matchDateTime;
    data['whoWinsTheToss'] = whoWinsTheToss;
    data['tossDetails'] = tossDetails;
    data['matchStatus'] = matchStatus;
    data['team1Batting'] = team1Batting;
    data['team2Batting'] = team2Batting;
    data['team1toss'] = team1toss;
    data['team2toss'] = team2toss;
    data['manOfTheMatch'] = manOfTheMatch;
    data['team1Score'] = team1Score;
    data['team2Score'] = team2Score;
    data['team1Overs'] = team1Overs;
    data['team2Overs'] = team2Overs;
    data['team1Balls'] = team1Balls;
    data['team2Balls'] = team2Balls;
    data['team1Outs'] = team1Outs;
    data['team2Outs'] = team2Outs;
    data['squad1'] = squad1;
    data['squad2'] = squad2;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['currentInning'] = currentInning;
    data['innings'] = innings;
    data['playerStats'] = playerStats;
    data['bowlerStats'] = bowlerStats;
    data['currentOver'] = currentOver;
    data['overs'] = overs;
    data['scorecard'] = scorecard;
    return data;
  }
}

class CurrentOver {
  int? number;
  List<Ball>? balls;

  CurrentOver({this.number, this.balls});

  CurrentOver.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    if (json['balls'] != null) {
      balls = <Ball>[];
      json['balls'].forEach((v) {
        balls!.add(Ball.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['number'] = number;
    if (balls != null) {
      data['balls'] = balls!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PlayerStats {
  Player? player;
  num? runs;
  num? ballsFaced;
  num? fours;
  num? sixes;
  num? strikeRate;

  PlayerStats({
    this.player,
    this.runs,
    this.ballsFaced,
    this.fours,
    this.sixes,
    this.strikeRate,
  });

  PlayerStats.fromJson(Map<String, dynamic> json) {
    player = json['player'] != null ? Player.fromJson(json['player']) : null;
    runs = json['runs'];
    ballsFaced = json['ballsFaced'];
    fours = json['fours'];
    sixes = json['sixes'];
    strikeRate = json['strikeRate'];
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
    return data;
  }
}

class BowlerStats {
  Player? player;
  num? overs;
  num? maidens;
  num? runsGiven;
  num? wickets;
  num? economy;
  num? fours;
  num? sixes;

  BowlerStats({
    this.player,
    this.overs,
    this.maidens,
    this.runsGiven,
    this.wickets,
    this.economy,
    this.fours,
    this.sixes,
  });

  BowlerStats.fromJson(Map<String, dynamic> json) {
    player = json['player'] != null ? Player.fromJson(json['player']) : null;
    overs = json['overs'];
    maidens = json['maidens'];
    runsGiven = json['runsGiven'];
    wickets = json['wickets'];
    economy = json['economy'];
    fours = json['fours'];
    sixes = json['sixes'];
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
    data['fours'] = fours;
    data['sixes'] = sixes;
    return data;
  }
}

class Over {
  final int number;
  final List<Ball> balls;

  Over({
    required this.number,
    required this.balls,
  });

  factory Over.fromJson(Map<String, dynamic> json) {
    return Over(
      number: json['number'] as int,
      balls: (json['balls'] as List<dynamic>)
          .map((ballJson) => Ball.fromJson(ballJson as Map<String, dynamic>))
          .toList(),
    );
  }
}
