import 'package:cricket_app/cubits/match/match_cubit.dart';
import 'package:cricket_app/custom_widgets/match_details_live_card.dart';
import 'package:cricket_app/screens/dashbord_screen/live_details/live_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class LiveTab extends StatefulWidget {
  const LiveTab({super.key});

  @override
  State<LiveTab> createState() => _LiveTabState();
}

class _LiveTabState extends State<LiveTab> {
  @override
  void initState() {
    if (MatchCubit.get(context).liveMatchDetailsList.isEmpty) {
      MatchCubit.get(context).getLiveMatches(user: true);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(children: [
        Expanded(
          child: BlocConsumer<MatchCubit, MatchState>(
            listener: (context, state) {
              if (state is MatchGetLiveSuccess) {
                MatchCubit.get(context).liveMatchDetailsList = state.res.data;
              }
            },
            builder: (context, state) {
              if (state is MatchLiveLoading) {
                return  ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: const MatchDetailsLiveCard(),
                        ),
                      );
                    });
              } else if (state is MatchGetLiveError) {
                return Center(child: Text(state.message));
              }

              return RefreshIndicator(
                onRefresh: () => MatchCubit.get(context).getLiveMatches(
                  user: true,
                ),
                child: ListView.builder(
                    itemCount:
                        MatchCubit.get(context).liveMatchDetailsList.length,
                    itemBuilder: (context, index) {
                      var match =
                          MatchCubit.get(context).liveMatchDetailsList[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LiveDetails(match: match),
                              ),
                            );
                          },
                          child: Hero(
                            tag: match.sId.toString(),
                            child: MatchDetailsLiveCard(match: match),
                          ),
                        ),
                      );
                    }),
              );
            },
          ),
        ),
        const SizedBox(height: 70)
      ]),
    );
  }
}
