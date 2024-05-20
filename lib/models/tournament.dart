import 'package:cricket_app/models/team.dart';

class Tournament {
  List<String>? admins;
  String? image;
  String? seriesName;
  String? seriesLocation;
  String? tournamentType;
  int? numberOfOvers;
  int? numberOfTeams;
  String? startDate;
  String? endDate;
  List<TeamModel>? teams;
  String? sId;
  int? iV;

  Tournament(
      {this.admins,
      this.image,
      this.seriesName,
      this.seriesLocation,
      this.tournamentType,
      this.numberOfOvers,
      this.numberOfTeams,
      this.startDate,
      this.endDate,
      this.teams,
      this.sId,
      this.iV});

  Tournament.fromJson(Map<String, dynamic> json) {
    admins = json['admins'] == null ? [] : json['admins'].cast<String>();
    image = json['image'];
    seriesName = json['seriesName'];
    seriesLocation = json['seriesLocation'];
    tournamentType = json['tournamentType'];
    numberOfOvers = json['numberOfOvers'];
    numberOfTeams = json['numberOfTeams'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    if (json['teams'] != null) {
      teams = <TeamModel>[];
      json['teams'].forEach((v) {
        teams!.add(TeamModel.fromJson(v));
      });
    }
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['admins'] = admins;
    data['image'] = image;
    data['seriesName'] = seriesName;
    data['seriesLocation'] = seriesLocation;
    data['tournamentType'] = tournamentType;
    data['numberOfOvers'] = numberOfOvers;
    data['numberOfTeams'] = numberOfTeams;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    if (teams != null) {
      data['teams'] = teams!.map((v) => v.toJson()).toList();
    }
    data['_id'] = sId;
    data['__v'] = iV;
    return data;
  }
}

class TeamModel {
  Team? team;
  bool? qualified;
  bool? eliminated;

  TeamModel({this.team, this.qualified = false, this.eliminated = false});

  TeamModel.fromJson(Map<String, dynamic> json) {
    team = json['team'] != null ? Team.fromJson(json['team']) : null;
    qualified = json['qualified'];
    eliminated = json['eliminated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['team'] = team;
    data['qualified'] = qualified;
    data['eliminated'] = eliminated;
    return data;
  }
}