// ignore_for_file: avoid_print, prefer_const_constructors, unnecessary_null_comparison, unnecessary_brace_in_string_interps, unused_import, unnecessary_import, use_build_context_synchronously

import 'dart:convert';

import 'package:cricket_app/constent/Global.dart';
import 'package:cricket_app/models/add_new_player_model.dart';
import 'package:cricket_app/models/add_new_team_model.dart';
import 'package:cricket_app/models/get_all_team_model.dart';
import 'package:cricket_app/models/get_player_list.dart';
import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/player_item.dart';
import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/teams/add_new_team.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;

class ApiServies {
  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  //// user carate account registration account api
  Future<void> userRegisterApi(
      String username, String email, String password, String phone) async {
    if (!isValidEmail(email)) {
      Get.snackbar(
        "Invalid Email",
        "Please enter a valid email address.",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    var url = Uri.parse('https://starsolutions.me/api/auth/register');

    print('api email: $errorPropertyTextConfiguration');
    print('api username: $username');
    print('api password: $password');
    print('api phone: $phone');

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
        headers: {'Content-Type': 'application/json'}, // Important
      );

      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        print('Success: ${response.body}');
        Get.snackbar(
          "User registered successfully",
          "User registration successful",
          snackPosition: SnackPosition.BOTTOM,
        );
      } else if (response.statusCode == 409) {
        // Assuming 409 is for user already exists
        print('User already registered');
        Get.snackbar(
          "User already registered",
          "Please try logging in or use a different email.",
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          "Registration Failed",
          "An error occurred: ${response.body}",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar(
        "Error",
        "An unexpected error occurred: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// add new player

  Future<AddNewPlayerModel?> addNewPlayer(
      AddNewPlayerModel data, BuildContext context) async {
    print('Player API calling=====>>> ');
    var url = Uri.parse('https://starsolutions.me/api/players/add-players');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data.toJson()),
      );

      print(response.body);

      if (response.statusCode == 200) {
        print("Player response ====>>>> ${response.body}");
        Get.snackbar("Success", "Player added successfully",
            snackPosition: SnackPosition.BOTTOM);

        Navigator.pop(context);
        return AddNewPlayerModel.fromJson(json.decode(response.body));
      } else {
        Get.snackbar("Error", "Failed to add player",
            snackPosition: SnackPosition.BOTTOM);
        return null;
      }
    } catch (e) {
      // Get.snackbar("Exception", "Exception occurred: $e",
      //     snackPosition: SnackPosition.BOTTOM);
      return null;
    }
  }

  //// get all player list

  // Stream<List<getPlayerList>> getUserAlllPlayerApi(String userId) async* {
  //   print("user id sss ===>>>>${userId}");
  //   print("PLAYER------");

  //   while (true) {
  //     final response = await http.get(Uri.parse(
  //         'https://starsolutions.me/api/players/all-players/${userId}'));

  //     print("player details ${response.body}");
  //     if (response.statusCode == 200) {
  //       // Decode the JSON response body into a map.
  //       Map<String, dynamic> responseBody = json.decode(response.body);

  //       // Use the correct key 'player' to access the list of players.
  //       List<dynamic> playersList = responseBody['player'] as List<dynamic>;

  //       // If 'player' is null, it means the key does not exist or the response does not contain any players.
  //       // You should handle this case to avoid runtime errors.
  //       if (playersList == null) {
  //         print("No players found.");
  //         yield [];
  //         continue; // Skip further processing and continue with the next iteration.
  //       }

  //       List<getPlayerList> allPlayer = playersList
  //           .map((player) =>
  //               getPlayerList.fromJson(player as Map<String, dynamic>))
  //           .toList();

  //       print("get player details: ${response.body}");

  //       // Yield the list of players to the stream.
  //       yield allPlayer;

  //       // Wait for 10 seconds before the next request (adjust as needed).
  //       await Future.delayed(Duration(seconds: 5));
  //     } else {
  //       throw Exception('Failed to load data');
  //     }
  //   }
  // }

  //// delte a spacific  player

  Future<void> deletePlayer(int playerId) async {
    final String url =
        'https://starsolutions.me/api/players/delete-players/$playerId';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      print(" delete responsee ===>>>>> ${response.body}");
      if (response.statusCode == 200) {
        print('Player deleted successfully.');
      } else {
        print('Failed to delete player. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Exception caught: $e');
    }
  }

  /////    add new team

  Future<AddNewTeamModel?> addNewTeam(
      AddNewTeamModel data, BuildContext context) async {
    print('Team  API calling=====>>> ');
    var url = Uri.parse('https://starsolutions.me/api/teams/add-teams');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data.toJson()),
      );

      print(response.body);

      if (response.statusCode == 200) {
        print("team response ====>>>> ${response.body}");
        Get.snackbar("Success", "team added successfully",
            snackPosition: SnackPosition.BOTTOM);

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => PlayerItem()));
        return AddNewTeamModel.fromJson(json.decode(response.body));
      } else {
        print("Error response ====>>>> ${response.body}");
        Get.snackbar("Error", "Failed to add team",
            snackPosition: SnackPosition.BOTTOM);
        return null;
      }
    } catch (e, stackTrace) {
      print("Exception occurred: $e\n$stackTrace");
      Get.snackbar("Exception", "Exception occurred: $e",
          snackPosition: SnackPosition.BOTTOM);
      return null;
    }
  }

  //// get all team

  Stream<List<GetAlllTeamModel>> getAllTeamApi(String userId) async* {
    print("user id sss ===>>>>${userId}");
    print("Team------");

    while (true) {
      final response = await http.get(
          Uri.parse('https://starsolutions.me/api/teams/all-teams/${userId}'));

      print("Team details ${response.body}");
      if (response.statusCode == 200) {
        // Decode the JSON response body into a map.
        Map<String, dynamic> responseBody = json.decode(response.body);

        // Use the correct key 'player' to access the list of players.
        List<dynamic> playersList = responseBody['teams'] as List<dynamic>;

        // If 'player' is null, it means the key does not exist or the response does not contain any players.
        // You should handle this case to avoid runtime errors.
        if (playersList == null) {
          print("No team found.");
          yield [];
          continue; // Skip further processing and continue with the next iteration.
        }

        List<GetAlllTeamModel> allTeam = playersList
            .map((player) =>
                GetAlllTeamModel.fromJson(player as Map<String, dynamic>))
            .toList();

        print("get team details: ${response.body}");

        // Yield the list of players to the stream.
        yield allTeam;

        // Wait for 10 seconds before the next request (adjust as needed).
        await Future.delayed(Duration(seconds: 5));
      } else {
        throw Exception('Failed to load data');
      }
    }
  }
}
