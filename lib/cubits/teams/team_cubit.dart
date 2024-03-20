import 'dart:io';

import 'package:cricket_app/controllers/admin/admin_controller.dart';
import 'package:cricket_app/models/api_response.dart';
import 'package:cricket_app/models/team.dart';
import 'package:cricket_app/utils/app_exception.dart';
import 'package:cricket_app/utils/network.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'team_states.dart';

class TeamCubit extends Cubit<TeamState> {
  TeamCubit() : super(TeamInit());

  var adminController = AdminController();

  void addTeam({required Team team, required File teamImage}) async {
    emit(TeamAddLoading());
    try {
      var network = await Network.check();
      if (network) {
        var response = await adminController.addTeam(
          team: team,
          imageFile: teamImage,
        );
        emit(TeamAddSuccess(response));
      } else {
        emit(TeamAddError('No internet connection'));
      }
    } catch (err) {
      // if exception type is not AppException then emit "Something went wrong"
      if (err is! AppException) {
        emit(TeamAddError('Something went wrong'));
      } else {
        emit(TeamAddError(err.toString()));
      }
    }
  }

  getInitialTeams() async {
    emit(TeamGetInitialLoading());
    try {
      var network = await Network.check();
      if (network) {
        var response = await adminController.getTeams();
        if (response.data.length > 0) {
          emit(TeamGetInitial(response));
        } else {
          emit(TeamEmptyState());
        }
      } else {
        emit(TeamGetError('No internet connection'));
      }
    } catch (err) {
      // if exception type is not AppException then emit "Something went wrong"
      print(err);
      if (err is! AppException) {
        emit(TeamGetError('Something went wrong'));
      } else {
        emit(TeamGetError(err.toString()));
      }
    }
  }

  // void getTeam(String teamId) async {
  //   emit(TeamGetTeamLoading());
  //   try {
  //     var network = await Network.check();
  //     if (network) {
  //       var response = await adminController.getTeam(teamId);
  //       emit(TeamGetTeam(response));
  //     } else {
  //       emit(TeamGetError('No internet connection'));
  //     }
  //   } catch (err) {
  //     // if exception type is not AppException then emit "Something went wrong"
  //     if (err is! AppException) {
  //       emit(TeamGetError('Something went wrong'));
  //     } else {
  //       emit(TeamGetError(err.toString()));
  //     }
  //   }
  // }

  // deleteTeam(String teamId) async {
  //   emit(TeamDeleteLoading());
  //   try {
  //     var network = await Network.check();
  //     if (network) {
  //       var response = await adminController.deleteTeam(teamId);
  //       emit(TeamDeleteSuccess(response));
  //     } else {
  //       emit(TeamDeleteError('No internet connection'));
  //     }
  //   } catch (err) {
  //     // if exception type is not AppException then emit "Something went wrong"
  //     if (err is! AppException) {
  //       emit(TeamDeleteError('Something went wrong'));
  //     } else {
  //       emit(TeamDeleteError(err.toString()));
  //     }
  //   }
  // }

  void updateTeam(Team team, File? image) async {
    emit(TeamUpdateLoading());
    try {
      var network = await Network.check();
      if (network) {
        var response = await adminController.updateTeam(
          team: team,
          imageFile: image,
        );
        emit(TeamUpdateSuccess(response));
      } else {
        emit(TeamUpdateError('No internet connection'));
      }
    } catch (err) {
      // if exception type is not AppException then emit "Something went wrong"
      if (err is! AppException) {
        emit(TeamUpdateError('Something went wrong'));
      } else {
        emit(TeamUpdateError(err.toString()));
      }
    }
  }
}
