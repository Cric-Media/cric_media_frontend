// ignore_for_file: prefer_const_constructors

import 'package:cricket_app/cubits/match/match_cubit.dart';
import 'package:cricket_app/custom_widgets/custom_up_coming_matches_card.dart';
import 'package:cricket_app/custom_widgets/placeholders/upcoming_match_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpComingItem extends StatefulWidget {
  const UpComingItem({super.key});

  @override
  State<UpComingItem> createState() => _UpComingItem();
}

class _UpComingItem extends State<UpComingItem> {
  @override
  void initState() {
    MatchCubit.get(context).getUpcomingMatches();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MatchCubit, MatchState>(
      listener: (context, state) {
        if (state is MatchUpcommingSuccess) {
          MatchCubit.get(context).upcomingMatchDetailsList = state.res.data;
        }
      },
      builder: (context, state) {
        if (state is MatchUpcommingLoading) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return UpcomingMatchPlaceholder();
            },
            itemCount: 6,
          );
        } else if (state is MatchGetUpcommingError) {
          return Center(
            child: Text(state.message),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount:
                    MatchCubit.get(context).upcomingMatchDetailsList.length,
                itemBuilder: (ctx, index) {
                  var match =
                      MatchCubit.get(ctx).upcomingMatchDetailsList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5),
                    child: UpCommingMachesCard(match: match, admin: true),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
