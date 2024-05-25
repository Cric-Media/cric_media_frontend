import 'package:cricket_app/models/points_table.dart';
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
  List<Group>? groups;
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
      this.groups,
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
    if (json['groups'] != null) {
      groups = <Group>[];
      json['groups'].forEach((v) {
        groups!.add(Group.fromJson(v));
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
    if (groups != null) {
      data['groups'] = groups!.map((v) => v.toJson()).toList();
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
    data['team'] = team?.toJson();
    data['qualified'] = qualified;
    data['eliminated'] = eliminated;
    return data;
  }
}

class Group {
  String? name;
  List<PointsTable>? pointsTable;
  List<String>? teams;
  String? id;

  Group({this.name, this.pointsTable, this.teams, this.id});

  // from json
  Group.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['pointsTable'] != null) {
      pointsTable = <PointsTable>[];
      json['pointsTable'].forEach((v) {
        pointsTable!.add(PointsTable.fromJson(v));
      });
    }
    teams = json['teams'] == null ? [] : json['teams'].cast<String>();
    id = json['_id'];
  }

  // to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (pointsTable != null) {
      data['pointsTable'] = pointsTable!.map((v) => v.toJson()).toList();
    }
    data['teams'] = teams;
    data['_id'] = id;
    return data;
  }
}
