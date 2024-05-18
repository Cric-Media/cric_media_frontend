import 'dart:io';

import 'package:cricket_app/controllers/admin/admin_controller.dart';
import 'package:cricket_app/models/api_response.dart';
import 'package:cricket_app/models/tournament.dart';
import 'package:cricket_app/utils/app_exception.dart';
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

  // Lists
  List<Tournament> tournaments = [];

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
      final response = await adminController.getTournament(tournamentId);
      emit(TournamentGetSuccess(response: response));
    } catch (e) {
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
      final response = await adminController.getInitialTournaments(
        isAdmin: isAdmin,
      );
      emit(TournamentGetInitialSuccess(response: response));
    } catch (e) {
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
}
