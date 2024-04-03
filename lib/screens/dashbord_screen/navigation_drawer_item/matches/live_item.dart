// ignore_for_file: prefer_const_constructors

import 'package:cricket_app/cubits/match/match_cubit.dart';
import 'package:cricket_app/custom_widgets/match_details_live_card.dart';
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
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: BlocConsumer<MatchCubit, MatchState>(
              listener: (context, state) {
                if (state is MatchGetLiveSuccess) {
                  MatchCubit.get(context).liveMatchDetailsList = state.res.data;
                }
              },
              builder: (context, state) {
                if (state is MatchLiveLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
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
                          horizontal: 10.0, vertical: 5),
                      child: MatchDetailsLiveCard(match: record),
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
