class AdminDetails {
  String? adminStatus;
  int? totalPlayers;
  int? totalTeams;
  int? totalTournaments;
  int? totalMatches;

  AdminDetails(
      {this.adminStatus,
      this.totalPlayers,
      this.totalTeams,
      this.totalTournaments,
      this.totalMatches});

  AdminDetails.fromJson(Map<String, dynamic> json) {
    adminStatus = json['adminStatus'];
    totalPlayers = json['totalPlayers'];
    totalTeams = json['totalTeams'];
    totalTournaments = json['totalTournaments'];
    totalMatches = json['totalMatches'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['adminStatus'] = adminStatus;
    data['totalPlayers'] = totalPlayers;
    data['totalTeams'] = totalTeams;
    data['totalTournaments'] = totalTournaments;
    data['totalMatches'] = totalMatches;
    return data;
  }
}
