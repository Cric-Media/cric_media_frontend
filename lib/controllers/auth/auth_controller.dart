import 'dart:convert';

import 'package:cricket_app/constants/app_url.dart';
import 'package:cricket_app/constants/global.dart';
import 'package:cricket_app/models/api_response.dart';
import 'package:cricket_app/models/user.dart';
import 'package:cricket_app/utils/api_manager.dart';

class AuthController {
  Future<ApiResponse> signup() async {
    final url = AuthUrl.signup;
    final email = await Global().getEmail();
    final body = {"email": email};
    final headers = {"Content-Type": "application/json"};
    final response = await ApiManager.postRequest(body, url, headers: headers);

    return ApiManager.returnModel(response);
  }

  Future<ApiResponse> verifyEmail(otp) async {
    final url = AuthUrl.verifyEmail;
    // Get all user info
    String? name = await Global().getName();
    String? email = await Global().getEmail();
    String? phone = await Global().getPhone();
    String? password = await Global().getPassword();

    final body = {
      "email": email,
      "code": otp,
      "password": password,
      "phone": phone,
      "fullname": name,
    };

    final headers = {"Content-Type": "application/json"};
    final response = await ApiManager.postRequest(body, url, headers: headers);
    return ApiManager.returnModel(response);
  }

  Future<ApiResponse> signin(String email, String password) async {
    final url = AuthUrl.signin;
    final body = {"email": email, "password": password};
    final headers = {"Content-Type": "application/json"};
    final response = await ApiManager.postRequest(body, url, headers: headers);
    print(response.body);
    var resBody = jsonDecode(response.body);
    return ApiResponse.fromJson(
        resBody, (p0) => User.fromJson(resBody['data']));
  }

  Future<void> getUser() async {}
}
