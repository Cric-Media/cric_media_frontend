import 'package:cricket_app/models/team.dart';

class PointsTable {
  String? tournament;
  Team? team;
  int? matchesPlayed;
  int? wins;
  int? losses;
  int? draws;
  int? points;
  double? netRunRate;
  int? runsScored;
  int? runsAgainst;
  double? oversFaced;

  PointsTable({
    this.tournament,
    this.team,
    this.matchesPlayed = 0,
    this.wins = 0,
    this.losses = 0,
    this.draws = 0,
    this.points = 0,
    this.netRunRate = 0.0,
    this.runsScored = 0,
    this.runsAgainst = 0,
    this.oversFaced = 0.0,
  });

  factory PointsTable.fromJson(Map<String, dynamic> json) {
    return PointsTable(
      tournament: json['tournament'],
      team: json['team'] != null ? Team.fromJson(json['team']) : null,
      matchesPlayed: json['matchesPlayed'],
      wins: json['wins'],
      losses: json['losses'],
      draws: json['draws'],
      points: json['points'],
      netRunRate: json['netRunRate'].toDouble(),
      runsScored: json['runsScored'],
      runsAgainst: json['runsAgainst'],
      oversFaced: json['oversFaced'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tournament': tournament,
      'team': team?.toJson(),
      'matchesPlayed': matchesPlayed,
      'wins': wins,
      'losses': losses,
      'draws': draws,
      'points': points,
      'netRunRate': netRunRate,
      'runsScored': runsScored,
      'runsAgainst': runsAgainst,
      'oversFaced': oversFaced,
    };
  }
}
