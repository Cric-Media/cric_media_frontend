// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'dart:convert';

import 'package:cricket_app/constent/Global.dart';
import 'package:cricket_app/screens/dashbord_screen/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Ensure you have GetX added to your pubspec.yaml
import 'package:http/http.dart' as http;

class RegistrationProvider extends ChangeNotifier {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> userRegisterApi(BuildContext context) async {
    setLoading(true);
    final username = usernameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final phone = phoneController.text.trim();
    var url = Uri.parse('https://starsolutions.me/api/auth/register');

    var data = {
      "name": username,
      "email": email,
      "password": password,
      "phone": phone,
    };

    try {
      var response = await http.post(
        url,
        body: json.encode(data),
        headers: {'Content-Type': 'application/json'},
      );

      print(response.body);
      if (response.statusCode == 200) {
        print("user successfly register ${response.body} ");
        final responseBody = jsonDecode(response.body);
        final userId = responseBody['response']['user']['id'].toString();
        Global().saveUserId(userId);
        print('User ID: $userId');

        Get.snackbar(
          "Registration Success",
          "User ID $userId registered successfully.",
          snackPosition: SnackPosition.BOTTOM,
        );

        setLoading(false);

        // Navigate to Dashboard Screen
        Get.offAll(() => DashBoardScreen());
      } else if (response.statusCode == 409) {
        setLoading(false);
        Get.dialog(
          AlertDialog(
            title: Text("Account Already Exists"),
            content: Text("The email is already registered. Try logging in."),
            actions: <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () => Get.back(),
              ),
            ],
          ),
        );
      } else {
        setLoading(false);
        Get.snackbar(
          "Registration Failed",
          "please provider user information.",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      setLoading(false);
      Get.snackbar(
        "Error",
        "user information wrong",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void printDetails() {
    print("username: ${usernameController.text}");
    print("email: ${emailController.text}");
    print("password: ${passwordController.text}");
    print("phone: ${phoneController.text}");
  }
}
