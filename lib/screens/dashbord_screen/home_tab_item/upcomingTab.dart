// ignore_for_file: prefer_const_constructors

import 'package:cricket_app/cubits/match/match_cubit.dart';
import 'package:cricket_app/custom_widgets/custom_up_coming_matches_card.dart';
import 'package:cricket_app/screens/dashbord_screen/home_tab_item/matchesDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpComingTab extends StatefulWidget {
  const UpComingTab({super.key});

  @override
  State<UpComingTab> createState() => _UpComingTabState();
}

class _UpComingTabState extends State<UpComingTab> {
  @override
  void initState() {
    MatchCubit.get(context).getUpcomingMatches(user: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(children: [
        Expanded(
          child: BlocConsumer<MatchCubit, MatchState>(
            listener: (context, state) {
              if (state is MatchUpcommingSuccess) {
                MatchCubit.get(context).upcomingMatchDetailsList =
                    state.res.data;
              }
            },
            builder: (context, state) {
              if (state is MatchUpcommingLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                  itemCount:
                      MatchCubit.get(context).upcomingMatchDetailsList.length,
                  itemBuilder: (context, index) {
                    var match =
                        MatchCubit.get(context).upcomingMatchDetailsList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MatcheDetails()));
                          },
                          child: UpCommingMachesCard(match: match)),
                    );
                  });
            },
          ),
        ),
        SizedBox(height: 70)
      ]),
    );
  }
}
