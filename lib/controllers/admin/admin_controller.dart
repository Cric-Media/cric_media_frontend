import 'dart:convert';
import 'dart:io';

import 'package:cricket_app/constants/app_url.dart';
import 'package:cricket_app/constants/global.dart';
import 'package:cricket_app/models/api_response.dart';
import 'package:cricket_app/models/player.dart';
import 'package:cricket_app/utils/api_manager.dart';
import 'package:cricket_app/utils/app_exception.dart';
import 'package:http/http.dart';

class AdminController {
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
    print(player.toJson());
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
    print(json);
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
    print(resBody['data']);
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
}
