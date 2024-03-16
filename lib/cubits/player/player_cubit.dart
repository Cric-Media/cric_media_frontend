import 'dart:io';

import 'package:cricket_app/controllers/admin/admin_controller.dart';
import 'package:cricket_app/models/api_response.dart';
import 'package:cricket_app/models/player.dart';
import 'package:cricket_app/utils/app_exception.dart';
import 'package:cricket_app/utils/network.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'player_states.dart';

class PlayerCubit extends Cubit<PlayerState> {
  PlayerCubit() : super(PlayerInit());

  var adminController = AdminController();

  void addPlayer({required Player player, required File playerImage}) async {
    emit(PlayerAddLoading());
    try {
      var network = await Network.check();
      if (network) {
        var response = await adminController.addPlayer(
          player: player,
          imageFile: playerImage,
        );
        emit(PlayerAddSuccess(response));
      } else {
        emit(PlayerAddError('No internet connection'));
      }
    } catch (err) {
      // if exception type is not AppException then emit "Something went wrong"
      if (err is! AppException) {
        emit(PlayerAddError('Something went wrong'));
      } else {
        emit(PlayerAddError(err.toString()));
      }
    }
  }

  getInitialPlayers() async {
    emit(PlayerGetInitialLoading());
    try {
      var network = await Network.check();
      if (network) {
        var response = await adminController.getAllPlayers();
        emit(PlayerGetInitial(response));
      } else {
        emit(PlayerGetError('No internet connection'));
      }
    } catch (err) {
      // if exception type is not AppException then emit "Something went wrong"
      if (err is! AppException) {
        emit(PlayerGetError('Something went wrong'));
      } else {
        emit(PlayerGetError(err.toString()));
      }
    }
  }
}
