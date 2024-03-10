// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cricket_app/apis_servies/api_servies.dart';
import 'package:cricket_app/constent/Global.dart';
import 'package:cricket_app/models/add_new_team_model.dart';
import 'package:cricket_app/models/get_all_team_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeamProvider extends ChangeNotifier {
  ApiServies servies = ApiServies();
  TeamProvider() {
    init();
  }

  init() async {
    String? userId = await Global().getUserId();
    if (userId != null) {
      getTeamsList(userId);
    } else {
      print('User ID is null');
    }
  }

  final basUrlImages = 'https://starsolutions.me/';

  String teamCacheKey = 'TeamCache';
  String teamCacheTimeKey = 'TeamCacheTime';
  final _appointmentsStreamController =
      StreamController<List<GetAlllTeamModel>>.broadcast();
  Stream<List<GetAlllTeamModel>> get getplayerListStream =>
      _appointmentsStreamController.stream;
  var AllTeamList = <GetAlllTeamModel>[];

  final teamNameController = TextEditingController();
  final teamLocation = TextEditingController();

  XFile? _pickedImage;
  final ImagePicker _imagePicker = ImagePicker();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  String get pickedImagePath => _pickedImage?.path ?? "";

  Future<void> pickImage() async {
    final pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    _pickedImage = pickedImage;
    notifyListeners();
  }

  Future<String?> convertImageToBase64(String imagePath) async {
    try {
      File imageFile = File(imagePath);
      Uint8List imageBytes = await imageFile.readAsBytes();
      String base64Image = base64Encode(imageBytes);
      return base64Image;
    } catch (e) {
      print("Error converting image to base64: $e");
      return null;
    }
  }

  /// add new team data

  Future<void> addNewTeamMethod(BuildContext context) async {
    setLoading(true);

    try {
      final id = await Global().getUserId();
      int? userId = int.tryParse(id.toString());

      if (_pickedImage == null) {
        print('No image selected');
        return;
      }

      String? base64Image = await convertImageToBase64(_pickedImage!.path);
      if (base64Image == null) {
        print('Failed to convert image to base64');
        return;
      }

      AddNewTeamModel addNewPlayerModel = AddNewTeamModel(
        id: TeamIdGenerator.nextId,
        name: teamNameController.text.toString(),
        createdBy: userId!,
        location: teamLocation.text.toString(),
        image: base64Image,
      );

      final AddNewTeamModel? result =
          await servies.addNewTeam(addNewPlayerModel, context);

      if (result != null) {
        print('Team has been successfully added.');
      } else {
        print('Failed to add team.');
      }
    } catch (e, stackTrace) {
      print('An error occurred: $e\n$stackTrace');
      // Handle more specific errors if needed
    } finally {
      setLoading(false);
    }
  }

  ////   get team data
  Future<void> getTeamsList(String userId) async {
    // AllTeamList.clear;
    print('Team LIST CALLING===>>>>');

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? cachedDatateam = prefs.getString(teamCacheKey);
    if (cachedDatateam != null) {
      List<dynamic> jsonList = json.decode(cachedDatateam);
      List<GetAlllTeamModel> cachedTeam =
          jsonList.map((json) => GetAlllTeamModel.fromJson(json)).toList();

      // Emit the cached list to the stream
      _appointmentsStreamController.add(cachedTeam);

      print("Loaded team data from cache");

      try {
        servies.getAllTeamApi(userId).listen(
          (List<GetAlllTeamModel> fetchedTeams) async {
            print('team api in provider 1  calling====>>>>>>');
            if (fetchedTeams.isNotEmpty) {
              bool hasNewData = fetchedTeams.length != cachedTeam.length ||
                  !listEquals(fetchedTeams, cachedTeam);

              if (hasNewData) {
                await prefs.setString(
                  teamCacheKey,
                  json.encode(
                      fetchedTeams.map((Team) => Team.toJson()).toList()),
                );
                await prefs.setInt(
                  teamCacheTimeKey,
                  DateTime.now().millisecondsSinceEpoch,
                );

                print(
                    'Local storage length updated to: ${fetchedTeams.length}');
                print("Fetched Team data from API and updated cache");

                // Emit the fetched list to the stream
                _appointmentsStreamController.add(fetchedTeams);
              }
            }
          },
          onError: (error) {
            print("Error fetching team data from API: $error");
          },
        );
      } catch (error) {
        print("Error fetching team data from API: $error");
      }
    } else {
      // Step 2: If local storage is empty, fetch data from API
      try {
        servies.getAllTeamApi(userId).listen(
          (List<GetAlllTeamModel> fetchedTeam) async {
            // If fetchedPlayers is not null or empty, update the cache
            if (fetchedTeam.isNotEmpty) {
              await prefs.setString(
                teamCacheKey,
                json.encode(
                  fetchedTeam.map((Team) => Team.toJson()).toList(),
                ),
              );
              await prefs.setInt(
                teamCacheTimeKey,
                DateTime.now().millisecondsSinceEpoch,
              );

              print('Local storage length updated to: ${fetchedTeam.length}');
              print("Fetched team data from API and updated cache");

              // Emit the fetched list to the stream
              _appointmentsStreamController.add(fetchedTeam);
            }
          },
          onError: (error) {
            print("Error fetching team data from API: $error");
          },
        );
      } catch (error) {
        print("Error fetching team data from API: $error");
      }
    }
  }
}

class TeamIdGenerator {
  static int _currentId = 0; // Initial ID

  static int get nextId {
    _currentId++; // Increment the ID for each new team
    return _currentId;
  }

  //// get alll Team
}
