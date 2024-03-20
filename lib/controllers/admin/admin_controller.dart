import 'dart:convert';
import 'dart:io';

import 'package:cricket_app/constants/app_url.dart';
import 'package:cricket_app/constants/global.dart';
import 'package:cricket_app/models/admin.dart';
import 'package:cricket_app/models/api_response.dart';
import 'package:cricket_app/models/player.dart';
import 'package:cricket_app/models/team.dart';
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
    print(resBody);
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

  Future<ApiResponse> getAllPlayers() async {
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

  Future<ApiResponse> getPlayer(String playerId) async {
    final url = AdminUrl.getPlayerDetail;
    final body = {"playerId": playerId};
    final headers = {"Content-Type": "application/json"};
    final response = await ApiManager.postRequest(body, url, headers: headers);
    var resBody = jsonDecode(response.body);
    if (resBody['success']) {
      Player player = Player.fromJson(resBody['data']);
      return ApiResponse.fromJson(resBody, (data) => player);
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
    print(body);
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

  // !TEAM SECTION //
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
    print(json);

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
    print(response.body);
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
    var request = MultipartRequest('POST', Uri.parse(url));

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
    print(json);

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
}
