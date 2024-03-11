// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print

import 'dart:convert';

import 'package:cricket_app/constent/global.dart';
import 'package:cricket_app/screens/dashbord_screen/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;

class UserLoginProvider extends ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> userLoginApi(BuildContext context) async {
    setLoading(true);
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    var url = Uri.parse('https://starsolutions.me/api/auth/login');

    var data = {"email": email, "password": password};

    try {
      var response = await http.post(
        url,
        body: json.encode(data),
        headers: {'Content-Type': 'application/json'}, // Important
      );
      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      final responseBody = jsonDecode(response.body);
      final userId = responseBody['response']['user']['id'].toString();
      Global().saveUserId(userId);
      print('User ID: $userId');

      if (response.statusCode == 200) {
        print('Success: ${response.body}');

        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        final String? password = responseBody['password'];
        print('Stored password: $password');
        setLoading(false);
        if (password != null) {
          setLoading(false);
        }
        Get.snackbar(
          "User login successfully",
          "User login successful",
          snackPosition: SnackPosition.BOTTOM,
        );

        Get.offAll(DashBoardScreen());
      } else {
        setLoading(false);
        Get.snackbar(
          "login Failed",
          "user not found ",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      setLoading(false);
      print('Error: $e');
      Get.snackbar(
        "Error",
        " user email and password wrong",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
