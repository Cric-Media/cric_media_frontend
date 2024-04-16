import 'package:cricket_app/cubits/match/match_cubit.dart';
import 'package:cricket_app/models/match_details.dart';
import 'package:cricket_app/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(),
      body: BlocConsumer<MatchCubit, MatchState>(
        listener: (context, state) {
          if (state is MatchGetSuccess) {
            match = state.res.data;
            if (match!.playerStats != null) {
              striker = match!.playerStats
                  ?.where((p) => p.player?.id == match!.striker?.id)
                  .toList()[0];
              nonStriker = match!.playerStats
                  ?.where((p) => p.player?.id == match!.nonStriker?.id)
                  .toList()[0];
            }
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
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
                                style: Theme.of(context).textTheme.titleMedium,
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
                            Text(
                              'Batsman',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
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
                            Text(
                              '${match?.striker?.name} *',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Expanded(
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
                                      "${striker?.strikeRate?.toStringAsFixed(2)}"),
                                  const SizedBox(width: 20),
                                ],
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              match?.nonStriker?.name ?? 'Non Striker',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Expanded(
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
                                      "${nonStriker?.strikeRate?.toStringAsFixed(2)}"),
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
                                  Text("M"),
                                  SizedBox(width: 20),
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
                            const Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text("0"),
                                  SizedBox(width: 20),
                                  Text("0"),
                                  SizedBox(width: 20),
                                  Text("0"),
                                  SizedBox(width: 20),
                                  Text("0"),
                                  SizedBox(width: 20),
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
                                            margin:
                                                const EdgeInsets.only(left: 8),
                                            child: CircleAvatar(
                                              backgroundColor: e.runsScored == 4
                                                  ? Colors.green
                                                  : e.runsScored == 6
                                                      ? Colors.red
                                                      : Colors.blue,
                                              child: Text(
                                                e.runsScored.toString(),
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
                Card(
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
                              value: MatchCubit.get(context).wide ?? false,
                              onChanged: (value) {
                                setState(() {
                                  MatchCubit.get(context).wide = value;
                                });
                              },
                            ),
                            CheckboxWidget(
                              text: "No Ball",
                              value: MatchCubit.get(context).noBall ?? false,
                              onChanged: (value) {
                                setState(() {
                                  MatchCubit.get(context).noBall = value;
                                });
                              },
                            ),
                            CheckboxWidget(
                              text: "Byes",
                              value: MatchCubit.get(context).byes ?? false,
                              onChanged: (value) {
                                setState(() {
                                  MatchCubit.get(context).byes = value;
                                });
                              },
                            ),
                            CheckboxWidget(
                              text: "Leg Byes",
                              value: MatchCubit.get(context).legByes ?? false,
                              onChanged: (value) {
                                setState(() {
                                  MatchCubit.get(context).legByes = value;
                                });
                              },
                            ),
                            const SizedBox(width: 16),
                            ElevatedButton(
                              onPressed: () {},
                              child: const Text("Retire"),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: const Text("Swap Batsman"),
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
                                    onPressed: () {},
                                    child: const Text("0"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      MatchCubit.get(context).scoreAction(
                                        widget.matchId,
                                        1,
                                      );
                                    },
                                    child: const Text("1"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      MatchCubit.get(context).scoreAction(
                                        widget.matchId,
                                        2,
                                      );
                                    },
                                    child: const Text("2"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      MatchCubit.get(context).scoreAction(
                                        widget.matchId,
                                        3,
                                      );
                                    },
                                    child: const Text("3"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      MatchCubit.get(context).scoreAction(
                                        widget.matchId,
                                        4,
                                      );
                                    },
                                    child: const Text("4"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      MatchCubit.get(context).scoreAction(
                                        widget.matchId,
                                        6,
                                      );
                                    },
                                    child: const Text("6"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: const Text("W"),
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
