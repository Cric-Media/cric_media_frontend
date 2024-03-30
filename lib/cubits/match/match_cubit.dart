import 'package:cricket_app/models/player.dart';
import 'package:cricket_app/models/team.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'match_states.dart';

class MatchCubit extends Cubit<MatchState> {
  MatchCubit() : super(MatchInitial());

  static MatchCubit get(context) => BlocProvider.of<MatchCubit>(context);

  // variables
  Team? team1, team2;
  List<Player> playerList = [];
  Set<Player> squad1 = {}, squad2 = {};
  String? matchType, ballType, pitchType;
  int? numberOfOvers, oversPerBowler;
  String? cityTown, ground, selectedDateTime, whoWinTheToss, tossDetails;
  bool? teamAToss, teamBToss, teamABat, teamBBat, teamABowl, teamBBowl;

  // functions
}
