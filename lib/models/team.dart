import 'admin.dart'; // Import the Admin class
import 'player.dart'; // Import the Player class

class Team {
  String? id;
  String? name;
  String? location;
  String? image;
  List<Admin>? admins;
  List<Player>? players;
  List<RecentPerformance>? recentPerformance;

  Team({
    this.id,
    this.name,
    this.location,
    this.image,
    this.admins,
    this.players,
    this.recentPerformance,
  });

  Team.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    location = json['location'];
    image = json['image'];
    if (json['admins'] != null) {
      admins = <Admin>[];
      json['admins'].forEach((v) {
        admins!.add(Admin.fromJson(v));
      });
    }
    if (json['players'] != null) {
      players = <Player>[];
      json['players'].forEach((v) {
        players!.add(Player.fromJson(v));
      });
    }
    if (json['recentPerformance'] != null) {
      recentPerformance = <RecentPerformance>[];
      json['recentPerformance'].forEach((v) {
        recentPerformance!.add(RecentPerformance.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    data['location'] = location;
    data['image'] = image;
    if (admins != null) {
      data['admin'] = admins!.map((admin) => admin.toJson()).toList();
    }
    if (players != null) {
      data['players'] = players!.map((player) => player.toJson()).toList();
    }
    if (recentPerformance != null) {
      data['recentPerformance'] =
          recentPerformance!.map((history) => history.toJson()).toList();
    }
    return data;
  }
}

class RecentPerformance {
  String? team;
  List<History>? history;
  String? sId;

  RecentPerformance({this.team, this.history, this.sId});

  RecentPerformance.fromJson(Map<String, dynamic> json) {
    team = json['team'];
    if (json['history'] != null) {
      history = <History>[];
      json['history'].forEach((v) {
        history!.add(History.fromJson(v));
      });
    }
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['team'] = team;
    if (history != null) {
      data['history'] = history!.map((v) => v.toJson()).toList();
    }
    data['_id'] = sId;
    return data;
  }
}

class History {
  bool? wins;
  int? wonByRuns;
  String? match;
  String? sId;

  History({this.wins, this.wonByRuns, this.match, this.sId});

  History.fromJson(Map<String, dynamic> json) {
    wins = json['wins'];
    wonByRuns = json['wonByRuns'];
    match = json['match'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wins'] = wins;
    data['wonByRuns'] = wonByRuns;
    data['match'] = match;
    data['_id'] = sId;
    return data;
  }
}
