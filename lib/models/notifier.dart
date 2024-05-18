import 'package:cricket_app/models/player.dart';
import 'package:cricket_app/models/team.dart';
import 'package:cricket_app/models/tournament.dart';

class Notifier {
  String? sId;
  String? admin;
  Tournament? tournament;
  Player? player;
  Team? team;
  String? type;
  String? createdAt;
  int? iV;

  Notifier({
    this.sId,
    this.admin,
    this.tournament,
    this.type,
    this.createdAt,
    this.iV,
  });

  Notifier.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    admin = json['admin'];
    tournament = json['tournament'] != null
        ? Tournament.fromJson(json['tournament'])
        : null;
    player = json['player'] != null ? Player.fromJson(json['player']) : null;
    team = json['team'] != null ? Team.fromJson(json['team']) : null;
    type = json['type'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['admin'] = admin;
    if (tournament != null) {
      data['tournament'] = tournament!.toJson();
    }
    if (player != null) {
      data['player'] = player!.toJson();
    }
    if (team != null) {
      data['team'] = team!.toJson();
    }
    data['type'] = type;
    data['createdAt'] = createdAt;
    data['__v'] = iV;
    return data;
  }
}
