import 'dart:convert';
import 'dart:developer';

import 'package:cricket_app/constants/app_url.dart';
import 'package:cricket_app/models/api_response.dart';
import 'package:cricket_app/models/player.dart';
import 'package:cricket_app/utils/api_manager.dart';
import 'package:cricket_app/utils/app_exception.dart';

class UserController {
  Future<ApiResponse> getPlayerDetails(String playerId) async {
    final url = "${UserUrl.getPlayerDetails}/$playerId";
    print(url);

    final response = await ApiManager.getRequest(url);
    log(response.body);
    var resBody = jsonDecode(response.body);
    if (resBody['success']) {
      return ApiResponse.fromJson(
          resBody, (p0) => Player.fromJson(resBody['data']));
    } else {
      throw AppException(resBody['message']);
    }
  }
}
