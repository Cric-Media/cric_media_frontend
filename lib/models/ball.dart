import 'package:cricket_app/models/player.dart';

class Ball {
  String? match;
  Player? bowler;
  Player? batsman;
  int? runsScored;
  bool? isExtra;
  String? extraType;
  bool? isWicket;
  String? description;
  String? ballTo;
  String? wicketType;
  Player? fielder;

  Ball({
    this.match,
    this.bowler,
    this.batsman,
    this.runsScored,
    this.isExtra,
    this.extraType,
    this.isWicket,
    this.description,
    this.ballTo,
    this.wicketType,
    this.fielder,
  });

  Ball.fromJson(Map<String, dynamic> json) {
    match = json['match'];
    bowler = json['bowler'] != null ? Player.fromJson(json['bowler']) : null;
    batsman = json['batsman'] != null ? Player.fromJson(json['batsman']) : null;
    runsScored = json['runsScored'];
    isExtra = json['isExtra'];
    description = json['description'];
    ballTo = json['ballTo'];
    extraType = json['extraType'];
    isWicket = json['isWicket'];
    wicketType = json['wicketType'];
    fielder = json['fielder'] != null ? Player.fromJson(json['fielder']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['match'] = match;
    data['bowler'] = bowler;
    data['batsman'] = batsman;
    data['runsScored'] = runsScored;
    data['isExtra'] = isExtra;
    data['description'] = description;
    data['ballTo'] = ballTo;
    data['extraType'] = extraType;
    data['isWicket'] = isWicket;
    data['wicketType'] = wicketType;
    data['fielder'] = fielder;
    return data;
  }
}
