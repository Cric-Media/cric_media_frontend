import 'package:cricket_app/cubits/match/match_cubit.dart';
import 'package:cricket_app/custom_widgets/match_details_live_card.dart';
import 'package:cricket_app/screens/dashbord_screen/live_details/live_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LiveTab extends StatelessWidget {
  const LiveTab({super.key});

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
                return const Center(
                  child: CircularProgressIndicator(),
                );
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
                                  builder: (context) =>
                                      LiveDetails(match: match),
                                ),
                              );
                            },
                            child: MatchDetailsLiveCard(match: match)),
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
