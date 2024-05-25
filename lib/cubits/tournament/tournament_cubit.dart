import 'dart:developer';
import 'dart:io';

import 'package:cricket_app/controllers/admin/admin_controller.dart';
import 'package:cricket_app/models/api_response.dart';
import 'package:cricket_app/models/match_details.dart';
import 'package:cricket_app/models/points_table.dart';
import 'package:cricket_app/models/tournament.dart';
import 'package:cricket_app/utils/app_exception.dart';
import 'package:cricket_app/utils/network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'tournament_states.dart';

class TournamentCubit extends Cubit<TournamentState> {
  TournamentCubit() : super(TournamentInitial());
  static TournamentCubit get(context) =>
      BlocProvider.of<TournamentCubit>(context);
  final adminController = AdminController();

  // Variables
  File? image;
  String? tournamentType, startDate, endDate, imageUrl;
  TextEditingController seriesName = TextEditingController();
  TextEditingController seriesLocation = TextEditingController();
  TextEditingController numberOfOvers = TextEditingController();
  TextEditingController numberOfTeams = TextEditingController();

  Tournament? tournament;

  String? groupName;

  // Lists
  List<Tournament> tournaments = [];
  List<Tournament> fiveTournaments = [];
  List<String> matchTypes = ["series", "qualifier", "semiFinal", "final"];
  List<MatchDetails> upcomingMatchDetailsList = [];
  List<MatchDetails> liveMatchDetailsList = [];
  List<PointsTable> pointsTable = [];

  // Selected variables
  String? selectedMatchType;

  // Helper function
  pickImage() async {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) {
      setImage(File(img.path));
    }
  }

  void setImage(File? file) {
    image = file;
    emit(TournamentImageChanged());
  }

  void clearFields() {
    image = null;
    imageUrl = null;
    tournamentType = null;
    startDate = null;
    endDate = null;
    seriesName.clear();
    seriesLocation.clear();
    numberOfOvers.clear();
    numberOfTeams.clear();
    // emit(TournamentClearFields());
  }

  void addTournament() async {
    emit(TournamentAddLoading());
    try {
      var network = await Network.check();

      if (!network) {
        emit(TournamentAddError(
            message: "Please check your internet connection"));
        return;
      }
      var data = {
        'image': image,
        'series_name': seriesName.text.trim(),
        'series_location': seriesLocation.text.trim(),
        'tournament_type': tournamentType,
        'number_of_overs': numberOfOvers.text.trim(),
        'number_of_teams': numberOfTeams.text.trim(),
        'start_date': startDate,
        'end_date': endDate,
      };
      final response = await adminController.addTournament(data);
      emit(TournamentAddSuccess(response: response));
    } catch (e) {
      if (e is AppException) {
        emit(TournamentAddError(message: e.message));
      } else {
        emit(TournamentAddError(message: "Something went wrong"));
      }
    }
  }

  void updateTournament(String tournamentId) async {
    emit(TournamentUpdateLoading());
    try {
      var network = await Network.check();

      if (!network) {
        emit(TournamentUpdateError(
            message: "Please check your internet connection"));
        return;
      }
      var data = {
        'id': tournamentId,
        'image': image,
        'series_name': seriesName.text.trim(),
        'series_location': seriesLocation.text.trim(),
        'tournament_type': tournamentType,
        'number_of_overs': numberOfOvers.text.trim(),
        'number_of_teams': numberOfTeams.text.trim(),
        'start_date': startDate,
        'end_date': endDate,
      };
      final response = await adminController.updateTournament(
        data: data,
      );
      emit(TournamentUpdateSuccess(response: response));
    } catch (e) {
      if (e is AppException) {
        emit(TournamentUpdateError(message: e.message));
      } else {
        emit(TournamentUpdateError(message: "Something went wrong"));
      }
    }
  }

  void getTournament(String tournamentId) async {
    emit(TournamentGetLoading());
    try {
      var network = await Network.check();

      if (!network) {
        emit(TournamentGetError(
            message: "Please check your internet connection"));
        return;
      }
      final response = await adminController.getTournament(tournamentId);
      emit(TournamentGetSuccess(response: response));
    } catch (e) {
      print(e);
      if (e is AppException) {
        emit(TournamentAddError(message: e.message));
      } else {
        emit(TournamentAddError(message: "Something went wrong"));
      }
    }
  }

  void getInitialTournaments({required bool isAdmin}) async {
    emit(TournamentGetInitialLoading());
    try {
      var network = await Network.check();

      if (!network) {
        emit(TournamentGetInitialError(
            message: "Please check your internet connection"));
        return;
      }
      final response = await adminController.getInitialTournaments(
        isAdmin: isAdmin,
      );
      emit(TournamentGetInitialSuccess(response: response));
    } catch (e) {
      print(e);
      if (e is AppException) {
        emit(TournamentGetInitialError(message: e.message));
      } else {
        emit(TournamentGetInitialError(message: "Something went wrong"));
      }
    }
  }

  void addTeam({
    required String tournamentId,
    required String teamId,
  }) async {
    emit(TournamentAddTeamLoading());
    try {
      var network = await Network.check();

      if (!network) {
        emit(TournamentAddTeamError(
            message: "Please check your internet connection"));
        return;
      }
      final response = await adminController.addTeamToTournament(
        tournamentId: tournamentId,
        teamId: teamId,
      );
      emit(TournamentAddTeamSuccess(response: response));
    } catch (e) {
      if (e is AppException) {
        emit(TournamentAddTeamError(message: e.message));
      } else {
        emit(TournamentAddTeamError(message: "Something went wrong"));
      }
    }
  }

  void removeTeam({
    required String tournamentId,
    required String teamId,
  }) async {
    emit(TournamentRemoveTeamLoading());
    try {
      var network = await Network.check();

      if (!network) {
        emit(TournamentRemoveTeamError(
            message: "Please check your internet connection"));
        return;
      }
      final response = await adminController.removeTeamFromTournament(
        tournamentId: tournamentId,
        teamId: teamId,
      );
      emit(TournamentRemoveTeamSuccess(response: response));
    } catch (e) {
      if (e is AppException) {
        emit(TournamentRemoveTeamError(message: e.message));
      } else {
        emit(TournamentRemoveTeamError(message: "Something went wrong"));
      }
    }
  }

// Matches ********************************
  void upComingMatches() async {
    emit(TournamentUpcomingMatchesLoading());
    try {
      var network = await Network.check();
      if (!network) {
        emit(TournamentUpcomingMatchesError(
            message: "Please check your internet connection"));
        return;
      }
      final response = await adminController.upComingMatches(
        tournament?.sId ?? "",
      );
      emit(TournamentUpcomingMatchesSuccess(response: response));
    } catch (e) {
      if (e is AppException) {
        emit(TournamentUpcomingMatchesError(message: e.message));
      } else {
        emit(TournamentUpcomingMatchesError(message: "Something went wrong"));
      }
    }
  }

  void getLiveMatches() async {
    emit(TournamentLiveMatchesLoading());
    try {
      var network = await Network.check();
      if (!network) {
        emit(TournamentLiveMatchesError(
            message: "Please check your internet connection"));
        return;
      }
      final response = await adminController.liveMatches(
        tournament?.sId ?? "",
      );
      emit(TournamentLiveMatchesSuccess(response: response));
    } catch (e) {
      if (e is AppException) {
        emit(TournamentLiveMatchesError(message: e.message));
      } else {
        emit(TournamentLiveMatchesError(message: "Something went wrong"));
      }
    }
  }

  void getFiveTournaments() async {
    emit(TournamentGetFiveLoading());
    try {
      var network = await Network.check();
      if (!network) {
        emit(TournamentGetFiveError(
            message: "Please check your internet connection"));
        return;
      }
      final response = await adminController.getFiveTournaments();
      emit(TournamentGetFiveSuccess(response: response));
    } catch (e) {
      if (e is AppException) {
        emit(TournamentGetFiveError(message: e.message));
      } else {
        emit(TournamentGetFiveError(message: "Something went wrong"));
      }
    }
  }

  void getTournamentPoints(String tournamentId, {String? group}) async {
    print(group);
    emit(TournamentPointsLoading());
    try {
      var network = await Network.check();

      if (!network) {
        emit(TournamentPointsError(
            message: "Please check your internet connection"));
        return;
      }
      final response = await adminController.getTournamentPoints(
        tournamentId,
        group: group,
      );
      emit(TournamentPointsSuccess(response: response));
    } catch (e) {
      if (e is AppException) {
        emit(TournamentPointsError(message: e.message));
      } else {
        emit(TournamentPointsError(message: "Something went wrong"));
      }
    }
  }

  void groupToTournament() async {
    emit(TournamentGroupToTournamentLoading());
    try {
      var network = await Network.check();
      if (!network) {
        emit(TournamentGroupToTournamentError(
            message: "Please check your internet connection"));
        return;
      }
      if (groupName == null || groupName!.isEmpty) {
        emit(TournamentGroupToTournamentError(
            message: "Please enter group name"));
        return;
      }
      final response = await adminController.groupToTournament(
        tournamentId: tournament?.sId ?? '',
        groupName: groupName ?? '',
      );
      emit(TournamentGroupToTournamentSuccess(response: response));
    } catch (e) {
      print(e);
      if (e is AppException) {
        emit(TournamentGroupToTournamentError(message: e.message));
      } else {
        emit(TournamentGroupToTournamentError(message: "Something went wrong"));
      }
    }
  }

  void teamToGroup({required String teamId, required String groupId}) async {
    emit(TournamentTeamsToGroupLoading());
    try {
      var network = await Network.check();

      if (!network) {
        emit(TournamentTeamsToGroupError(
            message: "Please check your internet connection"));
        return;
      }
      final response = await adminController.teamToGroup(
        tournamentId: tournament?.sId ?? '',
        teamId: teamId,
        groupId: groupId,
      );
      emit(TournamentTeamsToGroupSuccess(response: response));
    } catch (e) {
      log(e.toString());
      if (e is AppException) {
        emit(TournamentTeamsToGroupError(message: e.message));
      } else {
        emit(TournamentTeamsToGroupError(message: "Something went wrong"));
      }
    }
  }

  void removeGroupTeam({
    required String teamId,
    required String groupId,
  }) async {
    emit(TournamentRemoveGroupTeamLoading());
    try {
      var network = await Network.check();

      if (!network) {
        emit(TournamentRemoveGroupTeamError(
            message: "Please check your internet connection"));
        return;
      }
      final response = await adminController.removeGroupTeam(
        tournamentId: tournament?.sId ?? '',
        teamId: teamId,
        groupId: groupId,
      );
      emit(TournamentRemoveGroupTeamSuccess(response: response));
    } catch (e) {
      log(e.toString());
      if (e is AppException) {
        emit(TournamentRemoveGroupTeamError(message: e.message));
      } else {
        emit(TournamentRemoveGroupTeamError(message: "Something went wrong"));
      }
    }
  }
}
