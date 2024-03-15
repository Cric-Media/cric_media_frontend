import 'dart:convert';

import 'package:cricket_app/constants/app_url.dart';
import 'package:cricket_app/constants/global.dart';
import 'package:cricket_app/models/api_response.dart';
import 'package:cricket_app/models/admin.dart';
import 'package:cricket_app/utils/api_manager.dart';
import 'package:cricket_app/utils/app_exception.dart';

class AuthController {
  Future<ApiResponse> sendOtpForSignup() async {
    final url = AuthUrl.sendOtpForSignup;
    final email = await Global().getEmail();
    final body = {"email": email};
    final headers = {"Content-Type": "application/json"};
    final response = await ApiManager.postRequest(body, url, headers: headers);

    return ApiManager.returnModel(response);
  }

  Future<ApiResponse> verifyEmailAndSignup(otp) async {
    final url = AuthUrl.verifyEmailAndSignup;
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
    var resBody = jsonDecode(response.body);
    if (resBody['success']) {
      return ApiResponse.fromJson(
          resBody, (p0) => Admin.fromJson(resBody['data']));
    } else {
      throw AppException(resBody['message']);
    }
  }

  Future<ApiResponse> sendOtpForPasswordChange() async {
    final url = AuthUrl.sendOtpForPasswordChange;
    final email = await Global().getEmail();
    final body = {"email": email};
    final headers = {"Content-Type": "application/json"};
    final response = await ApiManager.postRequest(body, url, headers: headers);
    return ApiManager.returnModel(response);
  }

  Future<ApiResponse> verifyEmailForPassword(otp) async {
    final url = AuthUrl.verifyOtpForPasswordChange;
    final email = await Global().getEmail();
    final body = {"email": email, "code": otp};
    final headers = {"Content-Type": "application/json"};
    final response = await ApiManager.postRequest(body, url, headers: headers);
    return ApiManager.returnModel(response);
  }

  Future<ApiResponse> changePassword(password) async {
    final url = AuthUrl.changePassword;
    final email = await Global().getEmail();
    final body = {"email": email, "password": password};
    final headers = {"Content-Type": "application/json"};
    final response = await ApiManager.postRequest(body, url, headers: headers);
    return ApiManager.returnModel(response);
  }

  Future<ApiResponse> getUser() async {
    final userId = await Global().getUserId();
    final url = "${AuthUrl.getUser}/$userId";
    final headers = {"Content-Type": "application/json"};
    final response = await ApiManager.getRequest(url, headers: headers);
    var resBody = jsonDecode(response.body);
    if (resBody['success']) {
      return ApiResponse.fromJson(
          resBody, (p0) => Admin.fromJson(resBody['data']));
    } else {
      throw AppException(resBody['message']);
    }
  }
}
