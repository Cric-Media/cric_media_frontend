import 'dart:convert';
import 'dart:developer';

import 'package:cricket_app/constants/app_url.dart';
import 'package:cricket_app/models/api_response.dart';
import 'package:cricket_app/models/news.dart';
import 'package:cricket_app/models/player.dart';
import 'package:cricket_app/utils/api_manager.dart';
import 'package:cricket_app/utils/app_exception.dart';

class UserController {
  Future<ApiResponse> getPlayerDetails(String playerId) async {
    final url = "${UserUrl.getPlayerDetails}/$playerId";
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

  // * News Section ***
  Future<ApiResponse> getNews({required int page, int limit = 20}) async {
    final url = "${UserUrl.getNews}?page=$page&limit=$limit";
    var headers = <String, String>{
      'Content-Type': 'application/json',
    };
    final response = await ApiManager.getRequest(url, headers: headers);
    log(response.body);
    var resBody = jsonDecode(response.body);
    if (resBody['success']) {
      List<News> news = [];
      resBody['data'].forEach((v) {
        news.add(News.fromJson(v));
      });
      return ApiResponse.fromJson(resBody, (data) => news);
    } else {
      throw AppException(resBody['message']);
    }
  }
}
