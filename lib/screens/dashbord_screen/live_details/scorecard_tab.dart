import 'package:cached_network_image/cached_network_image.dart';
import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/cubits/match/match_cubit.dart';
import 'package:cricket_app/models/match_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScorecardTab extends StatefulWidget {
  final MatchDetails? match;
  const ScorecardTab({Key? key, required this.match}) : super(key: key);

  @override
  State<ScorecardTab> createState() => _ScorecardTabState();
}

class _ScorecardTabState extends State<ScorecardTab> {
  @override
  void initState() {
    MatchCubit.get(context).getMatchScoreCards(widget.match!.sId.toString());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MatchCubit, MatchState>(
      listener: (context, state) {
        if (state is MatchScoreCardsSuccess) {
          MatchCubit.get(context).scoreCards = state.res.data;
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var scorecard = MatchCubit.get(context).scoreCards[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              scorecard.battingTeam?.name ?? "",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 32),
                            const Row(
                              children: [
                                Text(
                                  "Batsmen",
                                  style: TextStyle(
                                    color: AppColor.blueColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text("R"),
                                      SizedBox(width: 16),
                                      Text("B"),
                                      SizedBox(width: 16),
                                      Text("4,s"),
                                      SizedBox(width: 16),
                                      Text("6,s"),
                                      SizedBox(width: 16),
                                      Text("SR"),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, i) {
                                var batsman = scorecard.batsmen![i];
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 16),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                              batsman.player?.imageUrl ?? "",
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        batsman.player?.name ?? "",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(batsman.runs.toString()),
                                            const SizedBox(width: 16),
                                            Text(batsman.ballsFaced.toString()),
                                            const SizedBox(width: 16),
                                            Text(batsman.fours.toString()),
                                            const SizedBox(width: 16),
                                            Text(batsman.sixes.toString()),
                                            const SizedBox(width: 16),
                                            Text(
                                              batsman.strikeRate!
                                                  .toStringAsFixed(2),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              itemCount: scorecard.batsmen!.length,
                              shrinkWrap: true,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      Card(
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              scorecard.bowlingTeam?.name ?? "",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 32),
                            const Row(
                              children: [
                                Text(
                                  "Bowling",
                                  style: TextStyle(
                                    color: AppColor.blueColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text("O"),
                                      SizedBox(width: 16),
                                      Text("W"),
                                      SizedBox(width: 16),
                                      Text("E"),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, i) {
                                var bowler = scorecard.bowlers![i];
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 16),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                              bowler.player?.imageUrl ?? "",
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        bowler.player?.name ?? "",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(bowler.overs.toString()),
                                            const SizedBox(width: 16),
                                            Text(bowler.wickets.toString()),
                                            const SizedBox(width: 16),
                                            Text(bowler.economy.toString()),
                                            const SizedBox(width: 16),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              itemCount: scorecard.bowlers!.length,
                              shrinkWrap: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
                itemCount: MatchCubit.get(context).scoreCards.length,
                shrinkWrap: true,
              ),
            ],
          ),
        );
      },
    );
  }
}
