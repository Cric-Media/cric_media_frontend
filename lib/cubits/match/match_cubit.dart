import 'dart:convert';
import 'dart:developer';

import 'package:cricket_app/constants/app_url.dart';
import 'package:cricket_app/constants/global.dart';
import 'package:cricket_app/controllers/admin/admin_controller.dart';
import 'package:cricket_app/models/api_response.dart';
import 'package:cricket_app/models/match_details.dart';
import 'package:cricket_app/models/player.dart';
import 'package:cricket_app/models/team.dart';
import 'package:cricket_app/utils/api_manager.dart';
import 'package:cricket_app/utils/app_exception.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'match_states.dart';

class MatchCubit extends Cubit<MatchState> {
  MatchCubit() : super(MatchInitial());

  static MatchCubit get(context) => BlocProvider.of<MatchCubit>(context);
  var adminController = AdminController();
  List<MatchDetails> liveMatchDetailsList = [];
  List<MatchDetails> upcomingMatchDetailsList = [];
  List<MatchDetails> completedMatchDetailsList = [];

  // variables
  Team? team1, team2;
  List<Player> playerList = [];
  Set<Player> squad1 = {}, squad2 = {};
  String? matchType, ballType, pitchType;
  int? numberOfOvers, oversPerBowler;
  String? cityTown, ground, matchDateTime, whoWinsToss, tossDetails;
  bool? teamAToss, teamBToss, teamABat, teamBBat, teamABowl, teamBBowl;

  // functions
  addMatchDetails() async {
    emit(MatchAddDetailsLoading());
    final url = AdminUrl.addMatchDetails;
    final myAdminId = await Global().getAdminId();
    final headers = {"Content-Type": "application/json"};

    if (teamAToss == true) {
      whoWinsToss = team1?.id;
    } else if (teamBToss == true) {
      whoWinsToss = team2?.id;
    }

    if (teamAToss == true && teamABat == true) {
      tossDetails = "Team ${team1?.name} won the toss and elected to bat first";
    } else if (teamAToss == true && teamABowl == true) {
      tossDetails =
          "Team ${team1?.name} won the toss and elected to bowl first";
    } else if (teamBToss == true && teamBBat == true) {
      tossDetails = "Team ${team2?.name} won the toss and elected to bat first";
    } else if (teamBToss == true && teamBBowl == true) {
      tossDetails =
          "Team ${team2?.name} won the toss and elected to bowl first";
    }

    try {
      final body = {
        "admin": myAdminId.toString(),
        "team1": team1?.id.toString(),
        "team2": team2?.id.toString(),
        "matchType": matchType.toString(),
        "ballType": ballType.toString(),
        "pitchType": pitchType.toString(),
        "numberOfOvers": numberOfOvers ?? 0,
        "oversPerBowler": oversPerBowler ?? 0,
        "cityOrTown": cityTown.toString(),
        "ground": ground.toString(),
        "matchDateTime": matchDateTime.toString(),
        "whoWinsTheToss": whoWinsToss.toString(),
        "tossDetails": tossDetails,
        "matchStatus": 0,
        "squad1": squad1.map((e) => e.id.toString()).toList(),
        "squad2": squad2.map((e) => e.id.toString()).toList(),
        "team1Batting": teamABat ?? false,
        "team2Batting": teamBBat ?? false,
        "team1toss": teamAToss ?? false,
        "team2toss": teamBToss ?? false,
        "team1Score": 0,
        "team2Score": 0,
        "team1Overs": 0,
        "team2Overs": 0,
        "team1Balls": 0,
        "team2Balls": 0,
        "team1Outs": 0,
        "team2Outs": 0
      };

      log(jsonEncode(body));

      final response =
          await ApiManager.postRequest(body, url, headers: headers);
      log(response.body);
      var resBody = jsonDecode(response.body);
      log(resBody);
      if (resBody['success']) {
        MatchAddDetailsSuccess(
          ApiResponse.fromJson(
            resBody,
            (data) => MatchDetails.fromJson(resBody['data']),
          ),
        );
      } else {
        throw AppException(resBody['message']);
      }
    } catch (err) {
      if (err is! AppException) {
        emit(
          MatchAddDetailsError("Something went wrong, please try again later"),
        );
      } else {
        MatchAddDetailsError(err.toString());
      }
    }
  }
}
