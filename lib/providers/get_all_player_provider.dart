import 'dart:async';
import 'dart:convert';

import 'package:cricket_app/apis_servies/database.dart'; // Make sure this is correctly imported
import 'package:cricket_app/constants/global.dart';
import 'package:cricket_app/models/get_player_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetAllPlayerProvider extends ChangeNotifier {
  DBHelper dbHelper = DBHelper();
  final StreamController<List<getPlayerList>> playerStreamController =
      StreamController.broadcast();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  GetAllPlayerProvider() {
    print(" provide calling---------");
    fetchAndShowLocalData();

    init();
  }

  init() async {
    print('Provider initializing...');
    String? userId = await Global().getAdminId();
    if (userId != null) {
      await fetchAndUpdateData(userId);
    } else {
      print('User ID is null');
    }
  }

  // Fetch and show data from the local database
  Future<void> fetchAndShowLocalData() async {
    await for (var localPlayers in dbHelper.getPlayerDataStream()) {
      if (localPlayers.isNotEmpty) {
        playerStreamController.add(localPlayers);
        break;
      }
    }
  }

  // Fetch new data from the API, update local database, and UI
  Future<void> fetchAndUpdateData(String userId) async {
    setLoading(true);
    try {
      List<getPlayerList> apiPlayers = await getUserAllPlayerApi(userId);
      if (apiPlayers.isNotEmpty) {
        await dbHelper.insertAll(apiPlayers);
        fetchAndShowLocalData();
        // Refresh local data display after updating
      }
    } catch (e) {
      print("Error fetching or updating player data: $e");
    }
    setLoading(false);
  }

  Stream<List<getPlayerList>> get playersStream =>
      playerStreamController.stream;

  @override
  void dispose() {
    playerStreamController.close();
    super.dispose();
  }
}

Future<List<getPlayerList>> getUserAllPlayerApi(String userId) async {
  try {
    final response = await http.get(
        Uri.parse('https://starsolutions.me/api/players/all-players/$userId'));
    if (response.statusCode == 200) {
      List<dynamic> playersList = json.decode(response.body)['player'];
      print("player item ===>>>${playersList.length}");
      return playersList
          .map((player) => getPlayerList.fromJson(player))
          .toList();
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    print('Error fetching players: $e');
    return [];
  }
}
