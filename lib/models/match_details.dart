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

  MatchDetails(
      {this.admin,
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
      this.iV});

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
    return data;
  }
}
