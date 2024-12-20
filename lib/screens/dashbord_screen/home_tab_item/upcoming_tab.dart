import 'package:cricket_app/cubits/match/match_cubit.dart';
import 'package:cricket_app/custom_widgets/custom_up_coming_matches_card.dart';
import 'package:cricket_app/custom_widgets/placeholders/upcoming_match_placeholder.dart';
import 'package:cricket_app/screens/dashbord_screen/home_tab_item/upcoming_match_details.dart';
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
    if (MatchCubit.get(context).upcomingMatchDetailsList.isEmpty) {
      MatchCubit.get(context).getUpcomingMatches(user: true);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
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
                return ListView.builder(itemBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    child: UpcomingMatchPlaceholder(),
                  );
                });
              }
              return RefreshIndicator(
                onRefresh: () async {
                  MatchCubit.get(context).getUpcomingMatches(user: true);
                },
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: MatchCubit.get(context)
                              .upcomingMatchDetailsList
                              .length,
                          itemBuilder: (context, index) {
                            var match = MatchCubit.get(context)
                                .upcomingMatchDetailsList[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            UpcomingMatchDetails(match: match),
                                      ));
                                },
                                child: Hero(
                                  tag: match.sId.toString(),
                                  child: UpCommingMachesCard(match: match),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 70)
      ]),
    );
  }
}
