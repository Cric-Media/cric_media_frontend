import 'dart:convert';
import 'dart:io';

import 'package:cricket_app/constants/app_url.dart';
import 'package:cricket_app/constants/global.dart';
import 'package:cricket_app/models/api_response.dart';
import 'package:cricket_app/models/player.dart';
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
}
