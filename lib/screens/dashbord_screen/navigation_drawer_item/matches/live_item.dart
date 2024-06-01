import 'package:cricket_app/constants/routes_names.dart';
import 'package:cricket_app/cubits/match/match_cubit.dart';
import 'package:cricket_app/custom_widgets/match_details_live_card.dart';
import 'package:cricket_app/custom_widgets/placeholders/live_match_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LiveItem extends StatefulWidget {
  const LiveItem({super.key});

  @override
  State<LiveItem> createState() => _LiveItem();
}

class _LiveItem extends State<LiveItem> {
  @override
  void initState() {
    MatchCubit.get(context).getLiveMatches();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: BlocConsumer<MatchCubit, MatchState>(
              listener: (context, state) {
                if (state is MatchGetLiveError) {}
                if (state is MatchGetLiveSuccess) {
                  MatchCubit.get(context).liveMatchDetailsList = state.res.data;
                }
              },
              builder: (context, state) {
                if (state is MatchLiveLoading) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return const LiveMatchPlaceholder();
                    },
                    itemCount: 6,
                  );
                } else if (state is MatchGetLiveError) {
                  return Center(child: Text(state.message));
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount:
                      MatchCubit.get(context).liveMatchDetailsList.length,
                  itemBuilder: (ctx, index) {
                    var record =
                        MatchCubit.get(context).liveMatchDetailsList[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4.0,
                        vertical: 5,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, setOpenings, arguments: {
                            "matchId": record.sId.toString(),
                            "teamABatting": record.team1Batting,
                            "teamBBatting": record.team2Batting,
                            "teamAId": record.team1?.id.toString(),
                            "teamBId": record.team2?.id.toString(),
                            "squad1": record.squad1 ?? [],
                            "squad2": record.squad2 ?? [],
                          });
                        },
                        child: MatchDetailsLiveCard(match: record),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
