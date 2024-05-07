import 'dart:convert';
import 'dart:developer';

import 'package:cricket_app/constants/app_url.dart';
import 'package:cricket_app/constants/global.dart';
import 'package:cricket_app/controllers/admin/admin_controller.dart';
import 'package:cricket_app/models/api_response.dart';
import 'package:cricket_app/models/match_details.dart';
import 'package:cricket_app/models/over.dart' as over;
import 'package:cricket_app/models/player.dart';
import 'package:cricket_app/models/score_card.dart';
import 'package:cricket_app/models/team.dart';
import 'package:cricket_app/utils/api_manager.dart';
import 'package:cricket_app/utils/app_exception.dart';
import 'package:cricket_app/utils/network.dart';
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
  int outPlayerIndex = 0;

  // Set openings
  List<Player> batsmen = [];
  List<Player> bowlers = [];

  Player? selectedStriker, selectedNonStriker, selectedBowler, manOfTheMatch;
  String? teamBatting;

  // Scorer
  bool? wide = false, noBall = false, byes, legByes;

  // Scorecards
  List<ScoreCard> scoreCards = [];
  String? wicketType;
  Player? selectedFielder;

  // Overs
  List<over.Over> overs = [];
  int overPage = 2, overLimit = 2;

  // functions
  resetBools() {
    wide = false;
    noBall = false;
    byes = false;
    legByes = false;
  }

  startStopAction(matchId, {String? reason}) async {
    emit(MatchStartStopLoading());
    try {
      var network = await Network.check();
      if (network) {
        var response = await adminController.startStopMatch(matchId, reason);
        emit(MatchStartStopSuccess(response));
      } else {
        emit(MatchStartStopError('No internet connection'));
      }
    } catch (err) {
      if (err is! AppException) {
        emit(
          MatchStartStopError("Something went wrong, please try again later"),
        );
      } else {
        emit(MatchStartStopError(err.toString()));
      }
    }
  }

  startMatch(String matchId) async {
    emit(MatchStartLoading());
    final url = "${AdminUrl.startMatch}/$matchId";
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
      // final body = {
      //   "admin": myAdminId.toString(),
      //   "team1": team1?.id.toString(),
      //   "team2": team2?.id.toString(),
      //   "matchType": matchType.toString(),
      //   "ballType": ballType.toString(),
      //   "pitchType": pitchType.toString(),
      //   "numberOfOvers": numberOfOvers ?? 0,
      //   "oversPerBowler": oversPerBowler ?? 0,
      //   "cityOrTown": cityTown.toString(),
      //   "ground": ground.toString(),
      //   "matchDateTime": matchDateTime.toString(),
      //   "whoWinsTheToss": whoWinsToss.toString(),
      //   "tossDetails": tossDetails,
      //   "matchStatus": 0,
      //   "squad1": squad1.map((e) => e.id.toString()).toList(),
      //   "squad2": squad2.map((e) => e.id.toString()).toList(),
      //   "team1Batting": teamABat ?? false,
      //   "team2Batting": teamBBat ?? false,
      //   "team1toss": teamAToss ?? false,
      //   "team2toss": teamBToss ?? false,
      //   "team1Score": 0,
      //   "team2Score": 0,
      //   "team1Overs": 0,
      //   "team2Overs": 0,
      //   "team1Balls": 0,
      //   "team2Balls": 0,
      //   "team1Outs": 0,
      //   "team2Outs": 0
      // };

      final body = {
        "whoWinsTheToss": whoWinsToss.toString(),
        "matchStatus": 1,
        "tossDetails": tossDetails.toString(),
        "squad1": squad1.map((e) => e.id.toString()).toList(),
        "squad2": squad2.map((e) => e.id.toString()).toList(),
        "team1Batting": teamABat ?? false,
        "team2Batting": teamBBat ?? false,
        "team1toss": teamAToss ?? false,
        "team2toss": teamBToss ?? false
      };

      final response = await ApiManager.putRequest(body, url, headers: headers);
      log(response.body);
      var resBody = jsonDecode(response.body);
      if (resBody['success']) {
        emit(
          MatchStartSuccess(
            ApiResponse.fromJson(resBody, (data) => null),
          ),
        );
      } else {
        throw AppException(resBody['message']);
      }
    } catch (err) {
      if (err is! AppException) {
        emit(
          MatchStartError("Something went wrong, please try again later"),
        );
      } else {
        emit(MatchStartError(err.toString()));
      }
    }
  }

  addMatchDetails() async {
    emit(MatchAddDetailsLoading());
    final url = AdminUrl.addMatchDetails;
    final adminId = await Global().getAdminId();
    final headers = {"Content-Type": "application/json"};

    try {
      final body = {
        "admin": adminId.toString(),
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
      };

      final response = await ApiManager.postRequest(
        body,
        url,
        headers: headers,
      );
      log(response.body);
      var resBody = jsonDecode(response.body);
      if (resBody['success']) {
        emit(MatchAddDetailsSuccess(
            ApiResponse.fromJson(resBody, (data) => null)));
      } else {
        throw AppException(resBody['message']);
      }
    } catch (err) {
      if (err is! AppException) {
        emit(
          MatchAddDetailsError("Something went wrong, please try again later"),
        );
      } else {
        emit(MatchAddDetailsError(err.toString()));
      }
    }
  }

  getCompletedMatches({bool user = false}) async {
    emit(MatchGetCompletedLoading());
    try {
      var network = await Network.check();
      if (network) {
        var response = await adminController.getCompletedMatches(user: user);
        emit(MatchGetCompletedSuccess(response));
      } else {
        emit(MatchGetCompletedError('No internet connection'));
      }
    } catch (err) {
      // if exception type is not AppException then emit "Something went wrong"
      if (err is! AppException) {
        emit(MatchGetCompletedError('Something went wrong'));
      } else {
        emit(MatchGetCompletedError(err.toString()));
      }
    }
  }

  getUpcomingMatches({bool user = false}) async {
    emit(MatchUpcommingLoading());
    try {
      var network = await Network.check();
      if (network) {
        var response = await adminController.getUpcomingMatches(user: user);
        emit(MatchUpcommingSuccess(response));
      } else {
        emit(MatchGetUpcommingError('No internet connection'));
      }
    } catch (err) {
      // if exception type is not AppException then emit "Something went wrong"
      if (err is! AppException) {
        emit(MatchGetUpcommingError('Something went wrong'));
      } else {
        emit(MatchGetUpcommingError(err.toString()));
      }
    }
  }

  // * Live Matches
  getLiveMatches({bool user = false}) async {
    emit(MatchLiveLoading());
    try {
      var network = await Network.check();
      if (network) {
        var response = await adminController.getLiveMatches(user: user);
        emit(MatchGetLiveSuccess(response));
      } else {
        emit(MatchGetLiveError('No internet connection'));
      }
    } catch (err) {
      // if exception type is not AppException then emit "Something went wrong"
      if (err is! AppException) {
        emit(MatchGetLiveError('Something went wrong'));
      } else {
        emit(MatchGetLiveError(err.toString()));
      }
    }
  }

  setOpenings(String matchId) async {
    emit(MatchSetOpeningsLoading());
    final url = AdminUrl.setOpenings;
    final headers = {"Content-Type": "application/json"};

    try {
      final body = {
        "matchId": matchId,
        "teamBatting": teamBatting.toString(),
        "openingBatsmen": [
          selectedStriker?.id.toString(),
          selectedNonStriker?.id.toString(),
        ],
        "openingBowler": selectedBowler?.id.toString()
      };

      log(jsonEncode(body));

      final response = await ApiManager.postRequest(
        body,
        url,
        headers: headers,
      );
      log(response.body);
      var resBody = jsonDecode(response.body);
      if (resBody['success']) {
        emit(
          MatchSetOpeningsSuccess(
            ApiResponse.fromJson(resBody, (data) => null),
          ),
        );
      } else {
        throw AppException(resBody['message']);
      }
    } catch (err) {
      if (err is! AppException) {
        emit(
          MatchStartError("Something went wrong, please try again later"),
        );
      } else {
        emit(MatchStartError(err.toString()));
      }
    }
  }

  getMatch(String matchId) async {
    try {
      var network = await Network.check();
      if (network) {
        var response = await adminController.getMatch(matchId);
        emit(MatchGetSuccess(response));
      } else {
        emit(MatchGetError('No internet connection'));
      }
    } catch (err) {
      // if exception type is not AppException then emit "Something went wrong"
      if (err is! AppException) {
        emit(MatchGetError('Something went wrong'));
      } else {
        emit(MatchGetError(err.toString()));
      }
    }
  }

  getMatchForInnings(String matchId) async {
    try {
      var network = await Network.check();
      if (network) {
        var response = await adminController.getMatch(matchId);
        emit(MatchGetForInningSuccess(response));
      } else {
        emit(MatchGetForInningError('No internet connection'));
      }
    } catch (err) {
      // if exception type is not AppException then emit "Something went wrong"
      if (err is! AppException) {
        emit(MatchGetForInningError('Something went wrong'));
      } else {
        emit(MatchGetForInningError(err.toString()));
      }
    }
  }

  getMatchScoreCards(String matchId) async {
    try {
      var network = await Network.check();
      if (network) {
        var response = await adminController.getMatchScoreCards(matchId);
        emit(MatchScoreCardsSuccess(response));
      } else {
        emit(MatchScoreCardsError('No internet connection'));
      }
    } catch (err) {
      if (err is! AppException) {
        emit(MatchScoreCardsError('Something went wrong'));
      } else {
        emit(MatchScoreCardsError(err.toString()));
      }
    }
  }

  getInitialOvers(String matchId) async {
    try {
      // Reset page for pagination
      overPage = 2;

      var network = await Network.check();
      if (network) {
        emit(MatchGetInitialOversLoading());
        final res = await adminController.getMatchOvers(matchId);
        emit(MatchGetInitialOversSuccess(res));
      } else {
        emit(MatchScoreCardsError('No internet connection'));
      }
    } catch (err) {
      if (err is! AppException) {
        emit(MatchGetInitialOversError('Something went wrong'));
      } else {
        emit(MatchGetInitialOversError(err.toString()));
      }
    }
  }

  getMoreOvers(
    String matchId, {
    required int page,
    required int limit,
  }) async {
    try {
      var network = await Network.check();
      if (network) {
        emit(MatchGetMoreOversLoading());
        final res = await adminController.getMatchOvers(
          matchId,
          page: page,
          limit: limit,
        );
        emit(MatchGetMoreOversSuccess(res));
      } else {
        emit(MatchScoreCardsError('No internet connection'));
      }
    } catch (err) {
      if (err is! AppException) {
        emit(MatchGetMoreOversError('Something went wrong'));
      } else {
        emit(MatchGetMoreOversError(err.toString()));
      }
    }
  }

  scoreAction(String matchId, int runsScored) async {
    try {
      emit(MatchLiveActionLoading());
      var network = await Network.check();
      if (network) {
        var response = await adminController.liveMatchAction(
          {
            "matchId": matchId,
            "actionType": "score",
            "data": {"runsScored": runsScored}
          },
        );
        emit(MatchLiveActionSuccess(response));
      } else {
        emit(MatchLiveActionError('No internet connection'));
      }
    } catch (err) {
      if (err is! AppException) {
        emit(MatchLiveActionError('Something went wrong'));
      } else {
        emit(MatchLiveActionError(err.toString()));
      }
    }
  }

  wideAction({
    required String matchId,
    required String actionType,
    required String extraType,
    required int extraRuns,
  }) async {
    try {
      emit(MatchLiveActionLoading());

      var network = await Network.check();
      if (network) {
        var response = await adminController.liveMatchAction(
          {
            "matchId": matchId,
            "actionType": actionType,
            "data": {"extraRuns": extraRuns, "extraType": extraType}
          },
        );
        emit(MatchLiveActionSuccess(response));
      } else {
        emit(MatchLiveActionError('No internet connection'));
      }
    } catch (err) {
      if (err is! AppException) {
        emit(MatchLiveActionError('Something went wrong'));
      } else {
        emit(MatchLiveActionError(err.toString()));
      }
    }
  }

  swapPlayersAction({
    required String matchId,
    required String actionType,
  }) async {
    try {
      emit(MatchLiveActionLoading());

      var network = await Network.check();
      if (network) {
        var response = await adminController.liveMatchAction(
          {"matchId": matchId, "actionType": actionType, "data": {}},
        );
        emit(MatchLiveActionSuccess(response));
      } else {
        emit(MatchLiveActionError('No internet connection'));
      }
    } catch (err) {
      if (err is! AppException) {
        emit(MatchLiveActionError('Something went wrong'));
      } else {
        emit(MatchLiveActionError(err.toString()));
      }
    }
  }

  changeBowlerAction(String matchId, String newBowlerId) async {
    try {
      var network = await Network.check();
      if (network) {
        adminController.liveMatchAction(
          {
            "matchId": matchId,
            "actionType": "changeBowler",
            "data": {"newBowler": newBowlerId}
          },
        );
      } else {
        emit(MatchLiveActionError('No internet connection'));
      }
    } catch (err) {
      if (err is! AppException) {
        emit(MatchLiveActionError('Something went wrong'));
      } else {
        emit(MatchLiveActionError(err.toString()));
      }
    }
  }

  outPlayerAction(String matchId, String playerIdOut) async {
    try {
      var network = await Network.check();
      if (network) {
        adminController.liveMatchAction(
          {
            "matchId": matchId,
            "actionType": "outPlayer",
            "data": {
              "playerIdOut": playerIdOut,
              "newPlayerId": selectedStriker == null
                  ? selectedNonStriker?.id.toString()
                  : selectedStriker?.id.toString(),
              "wicketType": wicketType,
              "fielder": selectedFielder?.id.toString(),
            }
          },
        );
      } else {
        emit(MatchLiveActionError('No internet connection'));
      }
    } catch (err) {
      if (err is! AppException) {
        emit(MatchLiveActionError('Something went wrong'));
      } else {
        emit(MatchLiveActionError(err.toString()));
      }
    }
  }

  byesLegByesAction(
    String matchId, {
    required int runsScored,
    required String extraType,
    String? noOrWide,
  }) async {
    try {
      emit(MatchLiveActionLoading());
      var network = await Network.check();
      if (network) {
        adminController.liveMatchAction(
          {
            "matchId": matchId,
            "actionType": "byes-LegByes",
            "data": noOrWide == null
                ? {"runsScored": runsScored, "extraType": extraType}
                : {
                    "runsScored": runsScored,
                    "extraType": extraType,
                    "noOrWide": noOrWide.toString(),
                  }
          },
        );
      } else {
        emit(MatchLiveActionError('No internet connection'));
      }
    } catch (err) {
      if (err is! AppException) {
        emit(MatchLiveActionError('Something went wrong'));
      } else {
        emit(MatchLiveActionError(err.toString()));
      }
    }
  }

  noBallAction(
    String matchId, {
    required int runsScored,
    required String extraType,
  }) async {
    try {
      emit(MatchLiveActionLoading());

      var network = await Network.check();
      if (network) {
        adminController.liveMatchAction(
          {
            "matchId": matchId,
            "actionType": "no ball",
            "data": {
              "runsScored": runsScored,
              "extraType": extraType,
            }
          },
        );
      } else {
        emit(MatchLiveActionError('No internet connection'));
      }
    } catch (err) {
      if (err is! AppException) {
        emit(MatchLiveActionError('Something went wrong'));
      } else {
        emit(MatchLiveActionError(err.toString()));
      }
    }
  }

  setManOfTheMatch({required String matchId, String? playerId}) {
    emit(MatchSetManOfTheMatchLoading());
    adminController.setManOfTheMatch(matchId, playerId).then((res) {
      emit(MatchSetManOfTheMatchSuccess(res));
    }).catchError((err) {
      if (err is! AppException) {
        emit(MatchSetManOfTheMatchError('Something went wrong'));
      } else {
        emit(MatchSetManOfTheMatchError(err.toString()));
      }
    });
  }
}
