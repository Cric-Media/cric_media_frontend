import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cricket_app/constants/app_url.dart';
import 'package:cricket_app/constants/global.dart';
import 'package:cricket_app/models/admin.dart';
import 'package:cricket_app/models/api_response.dart';
import 'package:cricket_app/models/match_details.dart';
import 'package:cricket_app/models/notifier.dart';
import 'package:cricket_app/models/over.dart' as Over;
import 'package:cricket_app/models/player.dart';
import 'package:cricket_app/models/score_card.dart';
import 'package:cricket_app/models/team.dart';
import 'package:cricket_app/models/tournament.dart';
import 'package:cricket_app/utils/api_manager.dart';
import 'package:cricket_app/utils/app_exception.dart';
import 'package:http/http.dart';

class AdminController {
  Future<ApiResponse> getOtherAdmins({
    int page = 1,
    int limit = 20,
    String? search,
  }) async {
    final url = AdminUrl.getOtherAdmins;
    final adminId = await Global().getAdminId();
    final body = {
      "adminID": adminId,
      "page": page,
      "limit": limit,
      "search": search,
    };
    final headers = {"Content-Type": "application/json"};
    final response = await ApiManager.postRequest(body, url, headers: headers);
    var resBody = jsonDecode(response.body);
    if (resBody['success']) {
      List<Admin> admins = [];
      for (var admin in resBody['data']) {
        admins.add(Admin.fromJson(admin));
      }
      return ApiResponse.fromJson(resBody, (data) => admins);
    } else {
      throw AppException(resBody['message']);
    }
  }

  Future<ApiResponse> addPlayer({
    required Player player,
    required File imageFile,
  }) async {
    final url = AdminUrl.addPlayer;
    final adminId = await Global().getAdminId();
    var request = MultipartRequest('POST', Uri.parse(url));

    // request.headers.addAll({
    //   "Content-Type": "multipart/form-data",
    //   "Authorization": "Bearer ${model.token}",
    // });

    request.files.add(
      MultipartFile(
        'Image',
        imageFile.readAsBytes().asStream(),
        imageFile.lengthSync(),
        filename: imageFile.path.split('/').last,
      ),
    );
    // send other fields
    request.fields["name"] = player.name.toString();
    request.fields["location"] = player.location.toString();
    request.fields["role"] = player.role.toString();
    request.fields["age"] = player.age.toString();
    request.fields["additionalInfo"] = player.additionalInfo.toString();
    request.fields["admins[0]"] = adminId.toString();

    // send request
    var response = await request.send();
    // print response
    var json = await response.stream.bytesToString();
    var body = jsonDecode(json);
    if (body['success'] == true) {
      return ApiResponse.fromJson(
        body,
        (data) => Player.fromJson(body['data']),
      );
    } else {
      throw AppException(body['message']);
    }
  }

  Future<ApiResponse> getPlayersByAdminId() async {
    final adminId = await Global().getAdminId();
    final url = "${AdminUrl.getAllPlayers}/$adminId";
    final headers = {"Content-Type": "application/json"};
    final response = await ApiManager.getRequest(url, headers: headers);
    var resBody = jsonDecode(response.body);
    if (resBody['success']) {
      List<Player> players = [];
      for (var player in resBody['data']) {
        players.add(Player.fromJson(player));
      }
      return ApiResponse.fromJson(resBody, (data) => players);
    } else {
      throw AppException(resBody['message']);
    }
  }

  Future<ApiResponse> getPlayersByTeamId(String teamId) async {
    final url = "${AdminUrl.getAllPlayersByTeamId}/$teamId";
    final headers = {"Content-Type": "application/json"};
    final response = await ApiManager.getRequest(url, headers: headers);
    var resBody = jsonDecode(response.body);
    if (resBody['success']) {
      List<Player> players = [];
      for (var player in resBody['data']) {
        players.add(Player(
          id: player['_id'],
          name: player['name'],
          location: player['location'],
          role: player['role'],
          imageUrl: player['Image'],
        ));
      }
      return ApiResponse.fromJson(resBody, (data) => players);
    } else {
      throw AppException(resBody['message']);
    }
  }

  Future<ApiResponse> deletePlayer(String playerId) async {
    final url = AdminUrl.deletePlayer;
    final headers = {"Content-Type": "application/json"};
    final body = {"playerId": playerId};
    final response =
        await ApiManager.deleteWithBodyRequest(body, url, headers: headers);
    var resBody = jsonDecode(response.body);
    if (resBody['success']) {
      return ApiResponse.fromJson(resBody, (data) => null);
    } else {
      throw AppException(resBody['message']);
    }
  }

  Future<ApiResponse> updatePlayer({
    required Player player,
    File? imageFile,
  }) async {
    final url = AdminUrl.updatePlayer;
    final adminId = await Global().getAdminId();
    var request = MultipartRequest('PUT', Uri.parse(url));

    // If an image file is provided, add it to the request
    if (imageFile != null) {
      request.files.add(
        MultipartFile(
          'Image',
          imageFile.readAsBytes().asStream(),
          imageFile.lengthSync(),
          filename: imageFile.path.split('/').last,
        ),
      );
    }

    // send other fields
    request.fields["playerId"] = player.id.toString();
    request.fields["name"] = player.name.toString();
    request.fields["location"] = player.location.toString();
    request.fields["role"] = player.role.toString();
    request.fields["age"] = player.age.toString();
    request.fields["additionalInfo"] = player.additionalInfo.toString();
    request.fields["admins[0]"] = adminId.toString();

    // send request
    var response = await request.send();
    // print response
    var json = await response.stream.bytesToString();
    var body = jsonDecode(json);
    if (body['success'] == true) {
      return ApiResponse.fromJson(
        body,
        (data) => Player.fromJson(body['data']),
      );
    } else {
      throw AppException(body['message']);
    }
  }

  Future<ApiResponse> sharePlayer(String playerId, String otherAdminId) async {
    final url = AdminUrl.sharePlayer;
    final myAdminId = await Global().getAdminId();
    final headers = {"Content-Type": "application/json"};
    final body = {
      "playerId": playerId,
      "adminId": myAdminId,
      "newAdmins": [otherAdminId]
    };
    final response = await ApiManager.putRequest(body, url, headers: headers);
    var resBody = jsonDecode(response.body);
    if (resBody['success']) {
      return ApiResponse.fromJson(resBody, (data) => null);
    } else {
      throw AppException(resBody['message']);
    }
  }

  // *TEAM SECTION //
  Future<ApiResponse> addTeam(
      {required Team team, required File imageFile}) async {
    final url = AdminUrl.createTeam;
    final adminId = await Global().getAdminId();
    var request = MultipartRequest('POST', Uri.parse(url));

    request.files.add(
      MultipartFile(
        'image',
        imageFile.readAsBytes().asStream(),
        imageFile.lengthSync(),
        filename: imageFile.path.split('/').last,
      ),
    );
    // send other fields

    request.fields["name"] = team.name.toString();
    request.fields["location"] = team.location.toString();
    request.fields["admin[0]"] = adminId.toString();

    // send request
    var response = await request.send();
    // print response
    var json = await response.stream.bytesToString();

    var body = jsonDecode(json);
    if (body['success'] == true) {
      return ApiResponse.fromJson(
        body,
        (data) => null,
      );
    } else {
      throw AppException(body['message']);
    }
  }

  Future<ApiResponse> getTeams() async {
    final adminId = await Global().getAdminId();
    final url = AdminUrl.getTeams;
    final headers = {"Content-Type": "application/json"};
    final body = {"adminId": adminId};
    final response = await ApiManager.postRequest(body, url, headers: headers);
    var resBody = jsonDecode(response.body);
    if (resBody['success']) {
      List<Team> teams = [];
      for (var team in resBody['data']) {
        teams.add(Team.fromJson(team));
      }
      return ApiResponse.fromJson(resBody, (data) => teams);
    } else {
      throw AppException(resBody['message']);
    }
  }

  Future<ApiResponse> updateTeam({required Team team, File? imageFile}) async {
    final url = AdminUrl.updateTeam;
    var request = MultipartRequest('PUT', Uri.parse(url));

    if (imageFile != null) {
      request.files.add(
        MultipartFile(
          'image',
          imageFile.readAsBytes().asStream(),
          imageFile.lengthSync(),
          filename: imageFile.path.split('/').last,
        ),
      );
    }
    // send other fields

    request.fields["teamID"] = team.id.toString();
    request.fields["name"] = team.name.toString();
    request.fields["location"] = team.location.toString();

    // send request
    var response = await request.send();
    // print response
    var json = await response.stream.bytesToString();

    var body = jsonDecode(json);
    if (body['success'] == true) {
      return ApiResponse.fromJson(body, (data) => null);
    } else {
      throw AppException(body['message']);
    }
  }

  Future<ApiResponse> deleteTeam(String teamId) async {
    final url = AdminUrl.deleteTeam;
    final headers = {"Content-Type": "application/json"};
    final body = {"teamID": teamId};
    final response = await ApiManager.deleteWithBodyRequest(
      body,
      url,
      headers: headers,
    );
    var resBody = jsonDecode(response.body);
    if (resBody['success']) {
      return ApiResponse.fromJson(resBody, (data) => null);
    } else {
      throw AppException(resBody['message']);
    }
  }

  Future<ApiResponse> shareTeam(String teamId, newAdminId) async {
    final url = AdminUrl.shareTeam;
    final myAdminId = await Global().getAdminId();
    final headers = {"Content-Type": "application/json"};
    final body = {
      "teamID": teamId,
      "adminId": myAdminId,
      "newAdmins": [newAdminId]
    };
    final response = await ApiManager.putRequest(body, url, headers: headers);
    var resBody = jsonDecode(response.body);
    if (resBody['success']) {
      return ApiResponse.fromJson(resBody, (data) => null);
    } else {
      throw AppException(resBody['message']);
    }
  }

  Future<ApiResponse> addPlayerToTeam(String playerId, String teamId) async {
    final url = AdminUrl.addPlayerToTeam;
    final headers = {"Content-Type": "application/json"};
    final teamAdmin = await Global().getAdminId();
    final body = {
      "teamID": teamId,
      "adminId": teamAdmin,
      "newPlayers": [playerId]
    };
    final response = await ApiManager.putRequest(body, url, headers: headers);
    var resBody = jsonDecode(response.body);
    if (resBody['success']) {
      return ApiResponse.fromJson(resBody, (data) => null);
    } else {
      throw AppException(resBody['message']);
    }
  }

  // * MATCH SECTION
  Future<ApiResponse> getUpcomingMatches({bool user = false}) async {
    final adminId = await Global().getAdminId();
    final url = user
        ? AdminUrl.getUpcomingMatches
        : "${AdminUrl.getUncomingMatchesByAdmin}/$adminId";
    final headers = {"Content-Type": "application/json"};
    final response = await ApiManager.getRequest(url, headers: headers);
    log(response.body);
    var resBody = jsonDecode(response.body);

    if (resBody['success']) {
      List<MatchDetails> matches = [];
      for (var match in resBody['data']) {
        matches.add(MatchDetails.fromJson(match));
      }
      return ApiResponse.fromJson(resBody, (data) => matches);
    } else {
      throw AppException(resBody['message']);
    }
  }

  Future<ApiResponse> getCompletedMatches({bool user = false}) async {
    final adminId = await Global().getAdminId();
    final url = user
        ? AdminUrl.getCompletedMatches
        : "${AdminUrl.getCompletedMatchesByAdmin}/$adminId";
    final headers = {"Content-Type": "application/json"};
    final response = await ApiManager.getRequest(url, headers: headers);
    log(response.body);
    var resBody = jsonDecode(response.body);

    if (resBody['success']) {
      List<MatchDetails> matches = [];
      for (var match in resBody['data']) {
        matches.add(MatchDetails.fromJson(match));
      }
      return ApiResponse.fromJson(resBody, (data) => matches);
    } else {
      throw AppException(resBody['message']);
    }
  }

  Future<ApiResponse> getLiveMatches({bool user = false}) async {
    final adminId = await Global().getAdminId();
    final url = user
        ? AdminUrl.getLiveMatches
        : "${AdminUrl.getLiveAdminMatches}/$adminId";
    final headers = {"Content-Type": "application/json"};
    final response = await ApiManager.getRequest(url, headers: headers);
    log(response.body);
    var resBody = jsonDecode(response.body);

    if (resBody['success']) {
      List<MatchDetails> matches = [];
      for (var match in resBody['data']) {
        matches.add(MatchDetails.fromJson(match));
      }
      return ApiResponse.fromJson(resBody, (data) => matches);
    } else {
      throw AppException(resBody['message']);
    }
  }

  Future<ApiResponse> getMatch(String matchId) async {
    final url = "${AdminUrl.getMatch}/$matchId";
    final headers = {"Content-Type": "application/json"};
    final response = await ApiManager.getRequest(url, headers: headers);
    log(response.body);
    var resBody = jsonDecode(response.body);
    if (resBody['success']) {
      return ApiResponse.fromJson(
        resBody,
        (data) => MatchDetails.fromJson(
          resBody['data'],
        ),
      );
    } else {
      throw AppException(resBody['message']);
    }
  }

  Future<ApiResponse> liveMatchAction(Map data) async {
    final url = AdminUrl.action;
    final headers = {"Content-Type": "application/json"};
    final response = await ApiManager.postRequest(data, url, headers: headers);
    log(response.body);
    var resBody = jsonDecode(response.body);
    if (resBody['success']) {
      return ApiResponse.fromJson(resBody, (data) => null);
    } else {
      throw AppException(resBody['message']);
    }
  }

  Future<ApiResponse> getMatchScoreCards(String matchId) async {
    final url = "${AdminUrl.matchScoreCards}/$matchId";
    final headers = {"Content-Type": "application/json"};
    final response = await ApiManager.getRequest(url, headers: headers);
    log(response.body);
    var resBody = jsonDecode(response.body);
    if (resBody['success']) {
      List<ScoreCard> scoreCards = [];
      for (var scoreCard in resBody['data']) {
        scoreCards.add(ScoreCard.fromJson(scoreCard));
      }
      return ApiResponse.fromJson(resBody, (data) => scoreCards);
    } else {
      throw AppException(resBody['message']);
    }
  }

  Future<ApiResponse> getMatchOvers(
    String matchId, {
    int page = 1,
    int limit = 2,
  }) async {
    final url = "${AdminUrl.getMatchOvers}/$matchId?page=$page&limit=$limit";
    final headers = {"Content-Type": "application/json"};
    final response = await ApiManager.getRequest(url, headers: headers);
    log(response.body);
    var resBody = jsonDecode(response.body);
    if (resBody['success']) {
      List<Over.Over> overs = [];
      for (var over in resBody['data']) {
        overs.add(Over.Over.fromJson(over));
      }
      return ApiResponse.fromJson(resBody, (data) => overs);
    } else {
      throw AppException(resBody['message']);
    }
  }

  Future<ApiResponse> setManOfTheMatch(matchId, playerId) async {
    final url = AdminUrl.setManOfTheMatch;
    final headers = {"Content-Type": "application/json"};
    final body = {"matchId": matchId, "playerId": playerId};
    final response = await ApiManager.putRequest(body, url, headers: headers);
    log(response.body);
    var resBody = jsonDecode(response.body);
    if (resBody['success']) {
      return ApiResponse.fromJson(resBody, (data) => null);
    } else {
      throw AppException(resBody['message']);
    }
  }

  Future<ApiResponse> startStopMatch(String matchId, String? reason) async {
    final url = AdminUrl.startStopMatch;
    final headers = {"Content-Type": "application/json"};
    final body = {"matchId": matchId, "reason": reason};
    final response = await ApiManager.putRequest(body, url, headers: headers);
    log(response.body);
    var resBody = jsonDecode(response.body);
    if (resBody['success']) {
      return ApiResponse.fromJson(
        resBody,
        (data) => MatchDetails.fromJson(resBody['data']),
      );
    } else {
      throw AppException(resBody['message']);
    }
  }

  // * TOURNAMENT SECTION
  Future<ApiResponse> addTournament(Map<String, dynamic> data) async {
    final url = AdminUrl.addTournament;
    // final headers = {"Content-Type": "application/json"};
    final adminId = await Global().getAdminId();
    var request = MultipartRequest('POST', Uri.parse(url));

    // request.headers.addAll({
    //   "Content-Type": "multipart/form-data",
    //   "Authorization": "Bearer ${model.token}",
    // });

    request.files.add(
      MultipartFile(
        'image',
        data['image'].readAsBytes().asStream(),
        data['image'].lengthSync(),
        filename: data['image'].path.split('/').last,
      ),
    );

    // send other fields
    request.fields["seriesName"] = data['series_name'].toString();
    request.fields["seriesLocation"] = data['series_location'].toString();
    request.fields["tournamentType"] = data['tournament_type'].toString();
    request.fields["numberOfOvers"] = data['number_of_overs'].toString();
    request.fields["numberOfTeams"] = data['number_of_teams'].toString();
    request.fields["startDate"] = data['start_date'].toString();
    request.fields["endDate"] = data['end_date'].toString();
    request.fields["admins[0]"] = adminId.toString();

    // send request
    var response = await request.send();
    // print response
    var json = await response.stream.bytesToString();
    var body = jsonDecode(json);
    if (body['success'] == true) {
      return ApiResponse.fromJson(
        body,
        (data) => Tournament.fromJson(body['data']),
      );
    } else {
      throw AppException(body['message']);
    }
  }

  Future<ApiResponse> updateTournament({
    required Map<String, dynamic> data,
  }) async {
    final url = "${AdminUrl.addTournament}/${data['id']}";
    var request = MultipartRequest('PUT', Uri.parse(url));

    if (data['image'] != null) {
      request.files.add(
        MultipartFile(
          'image',
          data['image'].readAsBytes().asStream(),
          data['image'].lengthSync(),
          filename: data['image'].path.split('/').last,
        ),
      );
    }
    // send other fields

    if (data['series_name'] != null) {
      request.fields["seriesName"] = data['series_name'].toString();
    }
    if (data['series_location'] != null) {
      request.fields["seriesLocation"] = data['series_location'].toString();
    }
    if (data['tournament_type'] != null) {
      request.fields["tournamentType"] = data['tournament_type'].toString();
    }
    if (data['number_of_overs'] != null) {
      request.fields["numberOfOvers"] = data['number_of_overs'].toString();
    }
    if (data['number_of_teams'] != null) {
      request.fields["numberOfTeams"] = data['number_of_teams'].toString();
    }
    if (data['start_date'] != null) {
      request.fields["startDate"] = data['start_date'].toString();
    }
    if (data['end_date'] != null) {
      request.fields["endDate"] = data['end_date'].toString();
    }

    // send request
    var response = await request.send();
    // print response
    var json = await response.stream.bytesToString();
    var body = jsonDecode(json);
    if (body['success'] == true) {
      return ApiResponse.fromJson(body, (data) => null);
    } else {
      throw AppException(body['message']);
    }
  }

  Future<ApiResponse> getTournament(String tournamentId) async {
    final url = "${AdminUrl.getTournament}/$tournamentId";
    final response = await ApiManager.getRequest(url);
    log(response.body);
    var resBody = jsonDecode(response.body);
    if (resBody['success']) {
      return ApiResponse.fromJson(
        resBody,
        (data) => Tournament.fromJson(resBody['data']),
      );
    } else {
      throw AppException(resBody['message']);
    }
  }

  Future<ApiResponse> getInitialTournaments({bool isAdmin = false}) async {
    final adminId = await Global().getAdminId();
    final url =
        "${AdminUrl.getTournaments}${isAdmin == true ? '?adminId=$adminId' : ''}";
    final headers = {"Content-Type": "application/json"};
    final response = await ApiManager.getRequest(url, headers: headers);
    var resBody = jsonDecode(response.body);
    if (resBody['success']) {
      List<Tournament> tournaments = [];
      for (var tournament in resBody['data']) {
        tournaments.add(Tournament.fromJson(tournament));
      }
      return ApiResponse.fromJson(resBody, (data) => tournaments);
    } else {
      throw AppException(resBody['message']);
    }
  }

  Future<ApiResponse> shareTournament({
    required String id,
    required String adminId,
    required String type,
  }) async {
    final url = AdminUrl.shareAccess;
    final headers = {"Content-Type": "application/json"};
    final body = {
      "adminId": adminId,
      "id": id,
      "type": type,
    };
    final response = await ApiManager.putRequest(body, url, headers: headers);
    log(response.body);
    var resBody = jsonDecode(response.body);
    if (resBody['success']) {
      return ApiResponse.fromJson(resBody, (data) => null);
    } else {
      throw AppException(resBody['message']);
    }
  }

  Future<ApiResponse> addTeamToTournament({
    required String tournamentId,
    required String teamId,
  }) async {
    final url = AdminUrl.teamToTournament;
    final headers = {"Content-Type": "application/json"};
    final body = {"tournamentId": tournamentId, "teamId": teamId};
    final response = await ApiManager.putRequest(body, url, headers: headers);
    var resBody = jsonDecode(response.body);
    if (resBody['success']) {
      return ApiResponse.fromJson(resBody, (data) => null);
    } else {
      throw AppException(resBody['message']);
    }
  }

  Future<ApiResponse> removeTeamFromTournament({
    required String tournamentId,
    required String teamId,
  }) async {
    final url = AdminUrl.teamToTournament;
    final headers = {"Content-Type": "application/json"};
    final body = {"tournamentId": tournamentId, "teamId": teamId};
    final response = await ApiManager.deleteRequest(url, body);
    var resBody = jsonDecode(response.body);
    if (resBody['success']) {
      return ApiResponse.fromJson(resBody, (data) => null);
    } else {
      throw AppException(resBody['message']);
    }
  }

  Future<ApiResponse> getAdminInvitations() async {
    final adminId = await Global().getAdminId();
    final url = "${AdminUrl.adminInvitations}/$adminId";
    final headers = {"Content-Type": "application/json"};

    final response = await ApiManager.getRequest(url);
    log(response.body);
    var resBody = jsonDecode(response.body);
    if (resBody['success']) {
      List<Notifier> notifiers = [];
      for (var notifier in resBody['data']) {
        notifiers.add(Notifier.fromJson(notifier));
      }
      return ApiResponse.fromJson(resBody, (data) => notifiers);
    } else {
      throw AppException(resBody['message']);
    }
  }

  Future<ApiResponse> invitationResponse({
    required String id,
    required String type,
    required bool accept,
  }) async {
    final adminId = await Global().getAdminId();
    final url = AdminUrl.invitationResponse;
    final headers = {"Content-Type": "application/json"};
    var body = {
      "adminId": adminId,
      "id": id,
      "accept": accept,
      "type": type,
    };
    final response = await ApiManager.putRequest(body, url, headers: headers);
    log(response.body);
    var resBody = jsonDecode(response.body);
    if (resBody['success']) {
      return ApiResponse.fromJson(resBody, (data) => null);
    } else {
      throw AppException(resBody['message']);
    }
  }

   Future<ApiResponse> upComingMatches(String tournamentId) async{
    final url = "${AdminUrl.tournamentUpcoming}/$tournamentId";
    final headers = {"Content-Type": "application/json"};
    final response = await ApiManager.getRequest(url, headers: headers);
    var resBody = jsonDecode(response.body);
    if (resBody['success']) {
      List<MatchDetails> matches = [];
      for (var match in resBody['data']) {
        matches.add(MatchDetails.fromJson(match));
      }
      return ApiResponse.fromJson(resBody, (data) => matches);
    } else {
      throw AppException(resBody['message']);
    }
  }

  Future<ApiResponse> liveMatches(String tournamentId) async {
    final url = "${AdminUrl.tournamentLive}/$tournamentId";
    final headers = {"Content-Type": "application/json"};
    final response = await ApiManager.getRequest(url, headers: headers);
    var resBody = jsonDecode(response.body);
    if (resBody['success']) {
      List<MatchDetails> matches = [];
      for (var match in resBody['data']) {
        matches.add(MatchDetails.fromJson(match));
      }
      return ApiResponse.fromJson(resBody, (data) => matches);
    } else {
      throw AppException(resBody['message']);
    }
  }
}
