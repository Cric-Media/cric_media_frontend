import 'package:cricket_app/constants/routes_names.dart';
import 'package:cricket_app/cubits/match/match_cubit.dart';
import 'package:cricket_app/models/match_details.dart';
import 'package:cricket_app/models/player.dart';
import 'package:cricket_app/services/socket_service.dart';
import 'package:cricket_app/utils/app_dialog.dart';
import 'package:cricket_app/utils/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeBowlerWidget extends StatefulWidget {
  const ChangeBowlerWidget({Key? key}) : super(key: key);

  @override
  State<ChangeBowlerWidget> createState() => _ChangeBowlerWidgetState();
}

class _ChangeBowlerWidgetState extends State<ChangeBowlerWidget> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<Player>(
      value: MatchCubit.get(context).selectedBowler,
      items: MatchCubit.get(context).bowlers.map((Player player) {
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
      Navigator.pushNamed(context, setOpenings, arguments: {});
    });
    super.initState();
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
                const ChangeBowlerWidget(),
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

  @override
  void dispose() {
    SocketService.instance.socket.off('match-${widget.matchId}');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int? bowlerStatsIndex = match?.bowlerStats?.indexWhere(
        (element) => element.player?.id == match?.openingBowler?.id);

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(),
      body: BlocConsumer<MatchCubit, MatchState>(
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
          }
          if (state is MatchLiveActionLoading) {
            AppDialogs.loadingDialog(context);
          } else if (state is MatchLiveActionError) {
            AppDialogs.closeDialog(context);
            showSnack(context, message: state.message);
          } else if (state is MatchLiveActionSuccess) {
            AppDialogs.closeDialog(context);
          }
        },
        builder: (context, state) {
          return Padding(
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Innings',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              if (match != null)
                                Text(
                                  '${match?.currentInning}',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                            ],
                          ),
                          // score section
                          const SizedBox(height: 20),
                          if (match != null)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Score',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Row(
                                  children: [
                                    if (match?.team1Batting == true)
                                      Text(
                                        "${match?.team1Score} - ${match?.team1Outs} (${match?.team2Overs}.${match?.team2Balls})",
                                      ),
                                    if (match?.team2Batting == true)
                                      Text(
                                        "${match?.team2Score} - ${match?.team2Outs} (${match?.team1Overs}.${match?.team1Balls})",
                                      ),
                                  ],
                                )
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'Batsman',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                              const Expanded(child: Text("")),
                              const Expanded(
                                flex: 3,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text("R"),
                                    SizedBox(width: 20),
                                    Text("B"),
                                    SizedBox(width: 20),
                                    Text("4s"),
                                    SizedBox(width: 20),
                                    Text("6s"),
                                    SizedBox(width: 20),
                                    Text("SR"),
                                    SizedBox(width: 20),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  '${match?.striker?.name ?? "Striker"} *',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text("${striker?.runs}"),
                                    const SizedBox(width: 20),
                                    Text("${striker?.ballsFaced}"),
                                    const SizedBox(width: 20),
                                    Text("${striker?.fours}"),
                                    const SizedBox(width: 20),
                                    Text("${striker?.sixes}"),
                                    const SizedBox(width: 20),
                                    Text(
                                      "${striker?.strikeRate?.toStringAsFixed(2)}",
                                    ),
                                    const SizedBox(width: 20),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  match?.nonStriker?.name ?? 'Non Striker',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text("${nonStriker?.runs}"),
                                    const SizedBox(width: 20),
                                    Text("${nonStriker?.ballsFaced}"),
                                    const SizedBox(width: 20),
                                    Text("${nonStriker?.fours}"),
                                    const SizedBox(width: 20),
                                    Text("${nonStriker?.sixes}"),
                                    const SizedBox(width: 20),
                                    Text(
                                      "${nonStriker?.strikeRate?.toStringAsFixed(2)}",
                                    ),
                                    const SizedBox(width: 20),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Bowler section
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Bowler',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text("O"),
                                    SizedBox(width: 20),
                                    // Text("M"),
                                    // SizedBox(width: 20),
                                    Text("R"),
                                    SizedBox(width: 20),
                                    Text("W"),
                                    SizedBox(width: 20),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                match?.openingBowler?.name ?? '',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              if (bowlerStatsIndex != null &&
                                  bowlerStatsIndex != -1)
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "${match!.bowlerStats![bowlerStatsIndex].overs}",
                                      ),
                                      // const SizedBox(width: 20),
                                      // Text(
                                      //   "${match!.bowlerStats![bowlerStatsIndex].maidens}",
                                      // ),
                                      const SizedBox(width: 20),
                                      Text(
                                        "${match!.bowlerStats![bowlerStatsIndex].runsGiven}",
                                      ),
                                      const SizedBox(width: 20),
                                      Text(
                                        "${match!.bowlerStats![bowlerStatsIndex].wickets}",
                                      ),
                                      const SizedBox(width: 20),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'This Over:',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              if (match != null)
                                Expanded(
                                  child: Wrap(
                                    children: match!.currentOver!.balls!
                                        .map((e) => Container(
                                              margin: const EdgeInsets.only(
                                                  left: 8),
                                              child: CircleAvatar(
                                                backgroundColor: e.runsScored ==
                                                        4
                                                    ? Colors.lightBlue
                                                    : e.runsScored == 6
                                                        ? Colors.pink
                                                        : e.isExtra == true
                                                            ? Colors.brown
                                                            : e.isWicket == true
                                                                ? Colors.red
                                                                : Colors.grey,
                                                child: Text(
                                                  (e.extraType == 'wides')
                                                      ? "WD"
                                                      : (e.isWicket == true)
                                                          ? "W"
                                                          : e.runsScored
                                                              .toString(),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Extra',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                Wrap(
                                  direction: Axis.horizontal,
                                  children: [
                                    CheckboxWidget(
                                      text: "Wide",
                                      value:
                                          MatchCubit.get(context).wide ?? false,
                                      onChanged: (value) {
                                        setState(() {
                                          MatchCubit.get(context).wide = value;
                                        });
                                      },
                                    ),
                                    CheckboxWidget(
                                      text: "No Ball",
                                      value: MatchCubit.get(context).noBall ??
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
                                          MatchCubit.get(context).byes ?? false,
                                      onChanged: (value) {
                                        setState(() {
                                          MatchCubit.get(context).byes = value;
                                        });
                                      },
                                    ),
                                    CheckboxWidget(
                                      text: "Leg Byes",
                                      value: MatchCubit.get(context).legByes ??
                                          false,
                                      onChanged: (value) {
                                        setState(() {
                                          MatchCubit.get(context).legByes =
                                              value;
                                        });
                                      },
                                    ),
                                    // const SizedBox(width: 32),
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
                                      child: const Text("Swap Batsman"),
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
                  Row(
                    children: [
                      // Expanded(
                      //   child: Card(
                      //     color: Colors.white,
                      //     child: Wrap(
                      //       direction: Axis.horizontal,
                      //       children: [
                      //         ElevatedButton(
                      //           onPressed: () {},
                      //           child: const Text("Undo"),
                      //         ),
                      //         ElevatedButton(
                      //           onPressed: () {},
                      //           child: const Text("Partnership"),
                      //         ),
                      //         ElevatedButton(
                      //           onPressed: () {},
                      //           child: const Text("Extras"),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      Expanded(
                        // flex: 2,
                        child: Card(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Action',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                Wrap(
                                  spacing: 10,
                                  direction: Axis.horizontal,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        if (MatchCubit.get(context).wide ==
                                            true) {
                                          MatchCubit.get(context).wideAction(
                                            matchId: widget.matchId,
                                            actionType: "wide",
                                            extraType: "wides",
                                            extraRuns: 0,
                                          );
                                        } else {
                                          MatchCubit.get(context).scoreAction(
                                            widget.matchId,
                                            0,
                                          );
                                        }
                                      },
                                      child: const Text("0"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        if (MatchCubit.get(context).wide ==
                                            true) {
                                          MatchCubit.get(context).wideAction(
                                            matchId: widget.matchId,
                                            actionType: "wide",
                                            extraType: "wides",
                                            extraRuns: 1,
                                          );
                                        } else {
                                          MatchCubit.get(context).scoreAction(
                                            widget.matchId,
                                            1,
                                          );
                                        }
                                      },
                                      child: const Text("1"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        if (MatchCubit.get(context).wide ==
                                            true) {
                                          MatchCubit.get(context).wideAction(
                                            matchId: widget.matchId,
                                            actionType: "wide",
                                            extraType: "wides",
                                            extraRuns: 2,
                                          );
                                        } else {
                                          MatchCubit.get(context).scoreAction(
                                            widget.matchId,
                                            2,
                                          );
                                        }
                                      },
                                      child: const Text("2"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        if (MatchCubit.get(context).wide !=
                                            true) {
                                          MatchCubit.get(context)
                                              .scoreAction(widget.matchId, 3);
                                        }
                                      },
                                      child: const Text("3"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        if (MatchCubit.get(context).wide !=
                                            true) {
                                          MatchCubit.get(context).scoreAction(
                                            widget.matchId,
                                            4,
                                          );
                                        }
                                      },
                                      child: const Text("4"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        if (MatchCubit.get(context).wide !=
                                            true) {
                                          MatchCubit.get(context).scoreAction(
                                            widget.matchId,
                                            6,
                                          );
                                        }
                                      },
                                      child: const Text("6"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        handlePlayerOut(
                                          context,
                                          widget.matchId,
                                        );
                                      },
                                      child: const Text("Out"),
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
                ],
              ),
            ),
          );
        },
      ),
    );
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
