import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/constants/routes_names.dart';
import 'package:cricket_app/cubits/match/match_cubit.dart';
import 'package:cricket_app/models/match_details.dart';
import 'package:cricket_app/models/player.dart';
import 'package:cricket_app/screens/dashbord_screen/live_details/live_details.dart';
import 'package:cricket_app/services/socket_service.dart';
import 'package:cricket_app/utils/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeBowlerWidget extends StatefulWidget {
  final MatchDetails? match;
  const ChangeBowlerWidget({Key? key, required this.match}) : super(key: key);

  @override
  State<ChangeBowlerWidget> createState() => _ChangeBowlerWidgetState();
}

class _ChangeBowlerWidgetState extends State<ChangeBowlerWidget> {
  @override
  void initState() {
    super.initState();
    MatchCubit.get(context).selectedBowler = null;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Player>(
      value: MatchCubit.get(context).selectedBowler,
      items: MatchCubit.get(context)
          .bowlers
          .where(
            (element) =>
                (widget.match?.oversCompletedPlayers?.contains(element.id) ==
                    false),
          )
          .map((Player player) {
        return DropdownMenuItem<Player>(
          value: player,
          child: Text(player.name ?? ''),
        );
      }).toList(),
      onChanged: (Player? newValue) {
        setState(() {
          MatchCubit.get(context).selectedBowler = newValue;
        });
      },
    );
  }
}

class LiveScorerScreen extends StatefulWidget {
  final String matchId;
  const LiveScorerScreen({Key? key, required this.matchId}) : super(key: key);

  @override
  State<LiveScorerScreen> createState() => _LiveScorerScreenState();
}

class _LiveScorerScreenState extends State<LiveScorerScreen> {
  MatchDetails? match;
  PlayerStats? striker, nonStriker;

  @override
  void initState() {
    MatchCubit.get(context).getMatch(widget.matchId);
    SocketService.instance.socket.on('match-${widget.matchId}', (data) {
      MatchCubit.get(context).getMatch(widget.matchId);
    });
    SocketService.instance.socket.on('overCompleted', (data) {
      // Handle over completion
      handleOverCompletion();
    });
    SocketService.instance.socket.on('inningCompleted', (data) {
      MatchCubit.get(context).getMatchForInnings(widget.matchId);
    });
    // SocketService.instance.socket.on('matchCompleted', (data) {
    //   handleMatchCompletion();
    // });
    super.initState();
  }

  @override
  void dispose() {
    SocketService.instance.socket.off('match-${widget.matchId}');
    SocketService.instance.socket.off('overCompleted');
    SocketService.instance.socket.off('inningCompleted');
    super.dispose();
  }

  handleInningsCompleted() {
    Navigator.pushNamedAndRemoveUntil(
        context,
        setOpenings,
        arguments: {
          "matchId": match?.sId.toString(),
          "teamABatting": match?.team1Batting,
          "teamBBatting": match?.team2Batting,
          "teamAId": match?.team1?.id.toString(),
          "teamBId": match?.team2?.id.toString(),
          "squad1": match?.squad1 ?? [],
          "squad2": match?.squad2 ?? [],
        },
        (route) => false);
  }

  handleMatchCompletion() {
    MatchCubit.get(context).manOfTheMatch = null;
    var team =
        match?.winningTeam == match?.team1?.id ? match?.squad1 : match?.squad2;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Match Completed"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Match has been completed"),
            ManOfTheMatchWidget(team: team),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              // Navigator.pop(context);
              MatchCubit.get(context).setManOfTheMatch(
                matchId: widget.matchId,
                playerId: MatchCubit.get(context).manOfTheMatch?.id.toString(),
              );
            },
            child: const Text("Continue"),
          ),
        ],
      ),
    );
  }

  handleOverCompletion() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Over Completed"),
              content: const Text("Select next bowler"),
              actions: [
                const Text(
                  "Bowler",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                ChangeBowlerWidget(match: match),
                ElevatedButton(
                  onPressed: () async {
                    await MatchCubit.get(context).changeBowlerAction(
                      widget.matchId,
                      MatchCubit.get(context).selectedBowler!.id.toString(),
                    );
                    Navigator.pop(context);
                  },
                  child: const Text("Continue"),
                ),
              ],
            ));
  }

  handlePlayerOut(BuildContext context, String matchId) {
    MatchCubit.get(context).selectedStriker = null;
    MatchCubit.get(context).selectedNonStriker = null;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Player Out'),
          content: SingleChildScrollView(
            child: OutPlayerWidget(match: match!),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Continue'),
              onPressed: () async {
                MatchCubit.get(context).outPlayerAction(
                  matchId,
                  MatchCubit.get(context).outPlayerIndex == 1
                      ? "${match?.striker?.id}"
                      : "${match?.nonStriker?.id}",
                );
                // Perform your action here
                // For example, you might want to call a method to change the player
                // await MatchCubit.get(context).changePlayerAction(matchId, newPlayerId);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  handleStopMatch(context) {
    String? reason;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          match?.matchStopped?.stop == true ? "Resume Match" : "Stop Match",
        ),
        content: Column(
          children: [
            Text(
              match?.matchStopped?.stop == true
                  ? "Are you sure you want to resume the match?"
                  : "Are you sure you want to stop the match?",
            ),
            match?.matchStopped?.stop == true
                ? const SizedBox()
                : TextField(
                    onChanged: (value) {
                      reason = value;
                    },
                    decoration: const InputDecoration(
                      hintText: "Reason?",
                    ),
                  ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (match?.matchStopped?.stop == true) {
                MatchCubit.get(context).startStopAction(widget.matchId);
              } else {
                MatchCubit.get(context).startStopAction(
                  widget.matchId,
                  reason: reason,
                );
              }
              Navigator.pop(context);
            },
            child: Text(match?.matchStopped?.stop == true ? "Resume" : "Stop"),
          ),
        ],
      ),
    );
  }

  handleDropMatch(context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Finish Match"),
        content: const Text("Are you sure you want to drop the match?"),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              MatchCubit.get(context).dropMatchAction(widget.matchId);
              Navigator.pop(context);
            },
            child: const Text("Drop"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        title: BlocBuilder<MatchCubit, MatchState>(
          builder: (context, state) {
            return Visibility(
              visible: match != null,
              child: Text(
                "${match?.team1?.name ?? ''} VS ${match?.team2?.name ?? ''}",
                style: const TextStyle(
                  color: AppColor.blueColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            );
          },
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LiveDetails(
                        match: match,
                        fromScorer: true,
                      ),
                    ));
              },
              child: const Text("Match")),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          MatchCubit.get(context).getMatch(widget.matchId);
        },
        child: BlocConsumer<MatchCubit, MatchState>(
          listener: (context, state) {
            if (state is MatchGetSuccess) {
              match = state.res.data;
              MatchCubit.get(context).resetBools();
              if (match!.playerStats != null) {
                striker = match?.playerStats?.firstWhere(
                  (p) => p.player?.id == match!.striker?.id,
                  orElse: () => PlayerStats(
                    player: match?.nonStriker,
                    runs: 0,
                    ballsFaced: 0,
                    fours: 0,
                    sixes: 0,
                    strikeRate: 0,
                  ),
                );

                nonStriker = match?.playerStats?.firstWhere(
                  (p) => p.player?.id == match!.nonStriker?.id,
                  orElse: () => PlayerStats(
                    player: match?.nonStriker,
                    runs: 0,
                    ballsFaced: 0,
                    fours: 0,
                    sixes: 0,
                    strikeRate: 0,
                  ),
                );
              }
            } else if (state is MatchGetForInningSuccess) {
              match = state.res.data;
              handleInningsCompleted();
            } else if (state is MatchLiveActionError) {
              print(state.message);
              showSnack(context, message: state.message);
            } else if (state is MatchSetManOfTheMatchSuccess) {
              Navigator.pushNamedAndRemoveUntil(
                  context, dashboard, (route) => false);
            } else if (state is MatchStartStopSuccess) {
              match = state.res.data;
            }
          },
          builder: (context, state) {
            int? bowlerStatsIndex = match?.bowlerStats?.indexWhere(
                (element) => element.player?.id == match?.openingBowler?.id);

            if (match != null && match!.matchStatus! > 1) {
              var team = match?.winningTeam == match?.team1?.id
                  ? match?.squad1
                  : match?.squad2;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if (match!.matchStatus! > 1)
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "Match has been completed",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),

                            // choose man of the match
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text("Man of the match ?"),
                                ManOfTheMatchWidget(team: team),
                              ],
                            ),
                            const SizedBox(height: 16),
                            OutlinedButton(
                              onPressed: () {
                                MatchCubit.get(context).setManOfTheMatch(
                                  matchId: widget.matchId,
                                  playerId: MatchCubit.get(context)
                                      .manOfTheMatch
                                      ?.id
                                      .toString(),
                                );
                              },
                              child: const Text("Continue"),
                            ),
                          ],
                        ),
                      ),
                    // if (match?.currentInning?.number == 2 &&
                    //     match?.currentInning?.started == false)
                    //   Center(
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       children: [
                    //         const SizedBox(height: 20),
                    //         ElevatedButton(
                    //           onPressed: () {
                    //             handleInningsCompleted();
                    //           },
                    //           child: const Text("Change Innings"),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                  ],
                ),
              );
            }

            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        //* Innings section
                        Card(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                // Inning section
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      match?.currentInning?.number == 1
                                          ? "1st Inning"
                                          : "2nd Inning",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    if (match != null) const Text("CRR"),
                                  ],
                                ),
                                // score section
                                const SizedBox(height: 20),
                                if (match != null)
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      if (match?.team1Batting == true)
                                        Row(
                                          children: [
                                            Text(
                                              "${match?.team1Score} - ${match?.team1Outs}",
                                              style: const TextStyle(
                                                fontSize: 23,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              "${match?.team2Overs}.${match?.team2Balls}",
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            ),
                                            // if (match?.team2Batting == true)
                                            //   Text(
                                            //     "${match?.team2Score} - ${match?.team2Outs} (${match?.team1Overs}.${match?.team1Balls})",
                                            //   ),
                                          ],
                                        ),
                                      if (match?.team2Batting == true)
                                        Row(
                                          children: [
                                            Text(
                                              "${match?.team2Score} - ${match?.team2Outs}",
                                              style: const TextStyle(
                                                fontSize: 23,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              "${match?.team1Overs}.${match?.team1Balls}",
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            ),
                                          ],
                                        ),
                                      // Row(
                                      //   children: [
                                      //     if (match?.team1Batting == true)
                                      //       Text(
                                      //         "${match?.team1Score} - ${match?.team1Outs} (${match?.team2Overs}.${match?.team2Balls})",
                                      //       ),
                                      //     if (match?.team2Batting == true)
                                      //       Text(
                                      //         "${match?.team2Score} - ${match?.team2Outs} (${match?.team1Overs}.${match?.team1Balls})",
                                      //       ),
                                      //   ],
                                      // ),
                                      if (match?.team1Batting == true)
                                        Text(
                                          "${match?.team1CurrentRunRate ?? 0}",
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                      if (match?.team2Batting == true)
                                        Text(
                                          "${match?.team2CurrentRunRate ?? 0}",
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        //* Batsmen and bowler section
                        Card(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                // Batsmen section
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        'Batsmen',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: const Text("R"),
                                            ),
                                          ),
                                          // SizedBox(width: 20),
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: const Text("B"),
                                            ),
                                          ),
                                          // SizedBox(width: 20),
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: const Text("4"),
                                            ),
                                          ),
                                          // SizedBox(width: 20),
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: const Text("6"),
                                            ),
                                          ),
                                          // SizedBox(width: 20),
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: const Text("S"),
                                            ),
                                          ),
                                          // SizedBox(width: 20),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                const Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        '${match?.striker?.name ?? "Striker"} *',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "${striker?.runs ?? 0}",
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              "${striker?.ballsFaced ?? 0}",
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              "${striker?.fours ?? 0}",
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              "${striker?.sixes ?? 0}",
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              "${striker?.strikeRate?.toStringAsFixed(0) ?? 0}",
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        match?.nonStriker?.name ??
                                            'Non Striker',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "${nonStriker?.runs ?? 0}",
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              "${nonStriker?.ballsFaced ?? 0}",
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              "${nonStriker?.fours ?? 0}",
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              "${nonStriker?.sixes ?? 0}",
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              "${nonStriker?.strikeRate?.toStringAsFixed(0) ?? 0}",
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 16),
                                // Bowler section
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        'Bowler',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 3,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "O",
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              "R",
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              "W",
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                const Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        match?.openingBowler?.name ?? 'Bowler',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ),
                                    if (bowlerStatsIndex != null &&
                                        bowlerStatsIndex != -1)
                                      Expanded(
                                        flex: 3,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "${match?.bowlerStats?[bowlerStatsIndex].overs}",
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                "${match?.bowlerStats?[bowlerStatsIndex].runsGiven}",
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                "${match?.bowlerStats?[bowlerStatsIndex].wickets}",
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        //* This over section
                        Card(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                // Over section
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'This Over:',
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    const SizedBox(width: 8),
                                    if (match != null)
                                      Expanded(
                                        child: Wrap(
                                          spacing: 4,
                                          children: match!.currentOver!.balls!
                                              .map((e) => Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                      bottom: 8,
                                                    ),
                                                    child: CircleAvatar(
                                                      radius: 16,
                                                      backgroundColor: e
                                                                  .runsScored ==
                                                              4
                                                          ? Colors.lightBlue
                                                          : (e.extraType ==
                                                                      "byes" ||
                                                                  e.extraType ==
                                                                      "leg byes")
                                                              ? Colors.orange
                                                              : (e.extraType ==
                                                                      "no ball")
                                                                  ? Colors
                                                                      .deepOrange
                                                                  : e.runsScored ==
                                                                          6
                                                                      ? Colors
                                                                          .pink
                                                                      : e.isExtra ==
                                                                              true
                                                                          ? Colors
                                                                              .brown
                                                                          : e.isWicket == true
                                                                              ? Colors.red
                                                                              : Colors.grey,
                                                      child: Text(
                                                        (e.extraType == 'wides')
                                                            ? "WD"
                                                            : (e.isWicket ==
                                                                    true)
                                                                ? "W"
                                                                : (e.extraType ==
                                                                        "byes")
                                                                    ? "b${e.runsScored}"
                                                                    : (e.extraType ==
                                                                            "leg byes")
                                                                        ? "lb${e.runsScored}"
                                                                        : (e.extraType ==
                                                                                "no ball")
                                                                            ? "NB${e.runsScored == 1 ? '' : e.runsScored}"
                                                                            : e.runsScored.toString(),
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ))
                                              .toList(),
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        //* Action buttons
                        Row(
                          children: [
                            Expanded(
                              child: Card(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Extra',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                      Wrap(
                                        spacing: 10,
                                        direction: Axis.horizontal,
                                        children: [
                                          CheckboxWidget(
                                            text: "Wide",
                                            value:
                                                MatchCubit.get(context).wide ??
                                                    false,
                                            onChanged: (value) {
                                              setState(() {
                                                MatchCubit.get(context).wide =
                                                    value;
                                              });
                                            },
                                          ),
                                          CheckboxWidget(
                                            text: "No Ball",
                                            value: MatchCubit.get(context)
                                                    .noBall ??
                                                false,
                                            onChanged: (value) {
                                              setState(() {
                                                MatchCubit.get(context).noBall =
                                                    value;
                                              });
                                            },
                                          ),
                                          CheckboxWidget(
                                            text: "Byes",
                                            value:
                                                MatchCubit.get(context).byes ??
                                                    false,
                                            onChanged: (value) {
                                              setState(() {
                                                MatchCubit.get(context).byes =
                                                    value;
                                              });
                                            },
                                          ),
                                          CheckboxWidget(
                                            text: "Leg Byes",
                                            value: MatchCubit.get(context)
                                                    .legByes ??
                                                false,
                                            onChanged: (value) {
                                              setState(() {
                                                MatchCubit.get(context)
                                                    .legByes = value;
                                              });
                                            },
                                          ),

                                          const SizedBox(width: 32),
                                          // ElevatedButton(
                                          //   onPressed: () {},
                                          //   child: const Text("Out"),
                                          // ),
                                          // const SizedBox(width: 32),
                                          ElevatedButton(
                                            onPressed: () {
                                              MatchCubit.get(context)
                                                  .swapPlayersAction(
                                                matchId: widget.matchId,
                                                actionType: "swap",
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  AppColor.blueColor,
                                              foregroundColor: Colors.white,
                                            ),
                                            child: const Text("Swap Batsman"),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              handlePlayerOut(
                                                context,
                                                widget.matchId,
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  AppColor.blueColor,
                                              foregroundColor: Colors.white,
                                            ),
                                            child: const Text("Out"),
                                          ),

                                          ElevatedButton(
                                            onPressed: () {
                                              if (match != null &&
                                                  match?.currentInning
                                                          ?.number ==
                                                      2 &&
                                                  match?.currentInning
                                                          ?.started ==
                                                      false) {
                                                handleInningsCompleted();
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: match != null &&
                                                      match?.currentInning
                                                              ?.number ==
                                                          2 &&
                                                      match?.currentInning
                                                              ?.started ==
                                                          false
                                                  ? AppColor.blueColor
                                                  : Colors.grey,
                                              foregroundColor: Colors.white,
                                            ),
                                            child: const Text("Change Innings"),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        //* Action buttons
                        SizedBox(
                          height: 200,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Card(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            handleStopMatch(context);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColor.blueColor,
                                            foregroundColor: Colors.white,
                                          ),
                                          child: Text(
                                            match?.matchStopped?.stop == true
                                                ? 'Resume'
                                                : "Stop",
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            if (match?.currentOver?.balls !=
                                                    null &&
                                                match!.currentOver!.balls!
                                                    .isEmpty) {
                                              handleOverCompletion();
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                match?.currentOver?.balls !=
                                                            null &&
                                                        match!.currentOver!
                                                            .balls!.isEmpty
                                                    ? AppColor.blueColor
                                                    : Colors.grey,
                                            foregroundColor: Colors.white,
                                          ),
                                          child: const Text("Bowler"),
                                        ),
                                        // if (match != null)
                                        //   ElevatedButton(
                                        //     onPressed: () {
                                        //       if (match!.matchStatus! > 1) {
                                        //         handleMatchCompletion();
                                        //       }
                                        //     },
                                        //     style: ElevatedButton.styleFrom(
                                        //       backgroundColor:
                                        //           match!.matchStatus! > 1
                                        //               ? AppColor.blueColor
                                        //               : Colors.grey,
                                        //       foregroundColor: Colors.white,
                                        //     ),
                                        //     child: const Text("Finish"),
                                        //   ),
                                        if (match != null)
                                          ElevatedButton(
                                            onPressed: () {
                                              handleDropMatch(context);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  AppColor.blueColor,
                                              foregroundColor: Colors.white,
                                            ),
                                            child: const Text("Drop"),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Card(
                                  elevation: 6,
                                  color: Colors.white,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Action',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge,
                                          ),
                                          Wrap(
                                            spacing: 4,
                                            direction: Axis.horizontal,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  // if (MatchCubit.get(context).wide ==
                                                  //     true) {
                                                  //   MatchCubit.get(context).wideAction(
                                                  //     matchId: widget.matchId,
                                                  //     actionType: "wide",
                                                  //     extraType: "wides",
                                                  //     extraRuns: 0,
                                                  //   );
                                                  // } else {
                                                  //   MatchCubit.get(context).scoreAction(
                                                  //     widget.matchId,
                                                  //     0,
                                                  //   );
                                                  // }
                                                  action(0);
                                                },
                                                child: const Text("0"),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  action(1);
                                                },
                                                child: const Text("1"),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  // MatchCubit.get(context).scoreAction(
                                                  //   widget.matchId,
                                                  //   2,
                                                  // );
                                                  action(2);
                                                },
                                                child: const Text("2"),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  // if (MatchCubit.get(context).wide !=
                                                  //     true) {
                                                  //   MatchCubit.get(context)
                                                  //       .scoreAction(widget.matchId, 3);
                                                  // }
                                                  action(3);
                                                },
                                                child: const Text("3"),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  // if (MatchCubit.get(context).wide !=
                                                  //     true) {
                                                  //   MatchCubit.get(context).scoreAction(
                                                  //     widget.matchId,
                                                  //     4,
                                                  //   );
                                                  // } else if (MatchCubit.get(context)
                                                  //         .wide ==
                                                  //     true) {
                                                  //   MatchCubit.get(context).wideAction(
                                                  //     matchId: widget.matchId,
                                                  //     actionType: "wide",
                                                  //     extraType: "wides",
                                                  //     extraRuns: 4,
                                                  //   );
                                                  // }
                                                  action(4);
                                                },
                                                child: const Text("4"),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  // if (MatchCubit.get(context).wide !=
                                                  //     true) {
                                                  //   MatchCubit.get(context).scoreAction(
                                                  //     widget.matchId,
                                                  //     6,
                                                  //   );
                                                  // }
                                                  action(6);
                                                },
                                                child: const Text("6"),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (state is MatchLiveActionLoading ||
                    state is MatchSetManOfTheMatchLoading ||
                    state is MatchStartStopLoading)
                  const Center(child: CircularProgressIndicator()),
              ],
            );
          },
        ),
      ),
    );
  }

  action(int runs) {
    bool notWideOrNo = MatchCubit.get(context).noBall != true &&
        MatchCubit.get(context).wide != true;
    bool noByesOrLb = MatchCubit.get(context).byes != true &&
        MatchCubit.get(context).legByes != true;

    bool isWide = MatchCubit.get(context).wide == true;
    bool isNo = MatchCubit.get(context).noBall == true;

    if (isWide) {
      MatchCubit.get(context).wideAction(
        matchId: widget.matchId,
        actionType: "wide",
        extraType: "wides",
        extraRuns: runs,
      );
    } else if (isNo) {
      MatchCubit.get(context)
          .noBallAction(widget.matchId, runsScored: runs, extraType: "no ball");
    }
    // Only No ball
    else if (noByesOrLb && MatchCubit.get(context).noBall == true) {
      MatchCubit.get(context)
          .noBallAction(widget.matchId, runsScored: runs, extraType: "no ball");
    }
    // Byes
    else if (MatchCubit.get(context).byes == true && notWideOrNo) {
      MatchCubit.get(context).byesLegByesAction(widget.matchId,
          runsScored: runs, extraType: "byes");
    }
    // byes with wide ball
    else if (MatchCubit.get(context).byes == true &&
        MatchCubit.get(context).wide == true) {
      MatchCubit.get(context).byesLegByesAction(widget.matchId,
          runsScored: runs, extraType: "byes", noOrWide: "wide");
    }
    // byes with no ball
    else if (MatchCubit.get(context).byes == true &&
        MatchCubit.get(context).noBall == true) {
      MatchCubit.get(context).byesLegByesAction(widget.matchId,
          runsScored: runs, extraType: "byes", noOrWide: "no ball");
    }
    // Leg byes
    else if (MatchCubit.get(context).legByes == true && notWideOrNo) {
      MatchCubit.get(context).byesLegByesAction(widget.matchId,
          runsScored: runs, extraType: "leg byes");
    }
    // leg byes with no ball
    else if (MatchCubit.get(context).legByes == true &&
        MatchCubit.get(context).noBall == true) {
      MatchCubit.get(context).byesLegByesAction(widget.matchId,
          runsScored: runs, extraType: "leg byes", noOrWide: "no ball");
    } else {
      MatchCubit.get(context).scoreAction(widget.matchId, runs);
    }
  }
}

class CheckboxWidget extends StatefulWidget {
  final bool? value;
  final void Function(bool?)? onChanged;
  final String text;
  const CheckboxWidget(
      {super.key, this.value, this.onChanged, required this.text});

  @override
  State<CheckboxWidget> createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Row(
        children: [
          Checkbox(
            value: widget.value,
            onChanged: widget.onChanged,
          ),
          Text(widget.text),
        ],
      ),
    );
  }
}

class OutPlayerWidget extends StatefulWidget {
  final MatchDetails match;
  const OutPlayerWidget({Key? key, required this.match}) : super(key: key);

  @override
  State<OutPlayerWidget> createState() => _OutPlayerWidgetState();
}

class _OutPlayerWidgetState extends State<OutPlayerWidget> {
  resetValues() {
    MatchCubit.get(context).selectedFielder = null;
    MatchCubit.get(context).wicketType = null;
  }

  @override
  void initState() {
    resetValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var fieldingTeam = widget.match.team1Batting == true
        ? widget.match.squad2
        : widget.match.squad1;

    return ListBody(
      children: <Widget>[
        const Text('Select a player to out.'),
        RadioListTile(
          value: 1,
          groupValue: MatchCubit.get(context).outPlayerIndex,
          onChanged: (value) {
            setState(() {
              MatchCubit.get(context).outPlayerIndex = value as int;
            });
          },
          title: Text(widget.match.striker?.name ?? ""),
        ),
        RadioListTile(
          value: 2,
          groupValue: MatchCubit.get(context).outPlayerIndex,
          onChanged: (value) {
            setState(() {
              MatchCubit.get(context).outPlayerIndex = value as int;
            });
          },
          title: Text(
            widget.match.nonStriker?.name ?? "",
            style: const TextStyle(color: Colors.black),
          ),
        ),
        const SizedBox(height: 32),
        const Text("Replace by ?"),
        DropdownButton<Player>(
          value: MatchCubit.get(context).outPlayerIndex == 1
              ? MatchCubit.get(context).selectedStriker
              : MatchCubit.get(context).selectedNonStriker,
          items: MatchCubit.get(context)
              .batsmen
              .where((player) =>
                  !widget.match.outPlayers!.contains(player.id.toString()))
              .map((Player player) {
            return DropdownMenuItem<Player>(
              value: player,
              child: Text(player.name ?? ''),
            );
          }).toList(),
          onChanged: (Player? newValue) {
            setState(() {
              if (MatchCubit.get(context).outPlayerIndex == 1) {
                MatchCubit.get(context).selectedStriker = newValue;
                MatchCubit.get(context).selectedNonStriker = null;
              } else {
                MatchCubit.get(context).selectedNonStriker = newValue;
                MatchCubit.get(context).selectedStriker = null;
              }
            });
          },
        ),
        const SizedBox(height: 16),
        const Text("Wicket Type"),
        DropdownButton<String>(
          value: MatchCubit.get(context).wicketType,
          items: [
            "Bowled",
            "Caught",
            "LBW",
            "Run Out",
            "Stumped",
            "Hit Wicket",
            "Handled Ball",
            "Obstructing Field",
            "Timed Out",
            "Hit Twice",
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              MatchCubit.get(context).wicketType = newValue;
            });
          },
        ),
        const SizedBox(height: 16),
        const Text("Fielder"),
        DropdownButton<Player>(
          value: MatchCubit.get(context).selectedFielder,
          items: fieldingTeam?.map((Player player) {
            return DropdownMenuItem<Player>(
              value: player,
              child: Text(player.name ?? ''),
            );
          }).toList(),
          onChanged: (Player? newValue) {
            setState(() {
              MatchCubit.get(context).selectedFielder = newValue;
            });
          },
        ),
      ],
    );
  }
}

class ManOfTheMatchWidget extends StatefulWidget {
  final List<Player>? team;
  const ManOfTheMatchWidget({Key? key, required this.team}) : super(key: key);

  @override
  State<ManOfTheMatchWidget> createState() => _ManOfTheMatchWidgetState();
}

class _ManOfTheMatchWidgetState extends State<ManOfTheMatchWidget> {
  @override
  void initState() {
    MatchCubit.get(context).manOfTheMatch = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Player>(
      value: MatchCubit.get(context).manOfTheMatch,
      hint: const Text("Man of the match"),
      items: widget.team?.map((Player player) {
        return DropdownMenuItem<Player>(
          value: player,
          child: Text(player.name ?? ''),
        );
      }).toList(),
      onChanged: (Player? newValue) {
        setState(() {
          MatchCubit.get(context).manOfTheMatch = newValue;
        });
      },
    );
  }
}
