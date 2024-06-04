import 'package:cricket_app/cubits/match/match_cubit.dart';
import 'package:cricket_app/custom_widgets/custom_resent_widget.dart';
import 'package:cricket_app/custom_widgets/placeholders/recent_match_placeholder.dart';
import 'package:cricket_app/screens/dashbord_screen/live_details/live_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecentTab extends StatefulWidget {
  const RecentTab({super.key});

  @override
  State<RecentTab> createState() => _RecentTabState();
}

class _RecentTabState extends State<RecentTab> {
  @override
  void initState() {
    super.initState();
    if (MatchCubit.get(context).completedMatchDetailsList.isEmpty) {
      MatchCubit.get(context).getCompletedMatches(user: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MatchCubit, MatchState>(
      listener: (context, state) {
        if (state is MatchGetCompletedSuccess) {
          MatchCubit.get(context).completedMatchDetailsList = state.res.data;
        } else if (state is MatchGetMoreCompletedSuccess) {
          MatchCubit.get(context)
              .completedMatchDetailsList
              .addAll(state.res.data);
        }
      },
      builder: (context, state) {
        if (state is MatchGetCompletedLoading) {
          return ListView.builder(itemBuilder: (context, index) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: RecentMatchPlaceholder(),
            );
          });
        } else if (state is MatchGetCompletedError) {
          return Center(child: Text(state.message));
        }
        return RefreshIndicator(
          onRefresh: () async {
            MatchCubit.get(context).getCompletedMatches(user: true);
          },
          child: Column(
            children: [
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount:
                      MatchCubit.get(context).completedMatchDetailsList.length +
                          1,
                  itemBuilder: (context, index) {
                    if (index ==
                        MatchCubit.get(context)
                            .completedMatchDetailsList
                            .length) {
                      // This is the last item, which is the "Load More" button
                      return BlocBuilder<MatchCubit, MatchState>(
                        builder: (context, state) {
                          if (state is MatchGetMoreCompletedLoading) {
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4.0, vertical: 5),
                            child: ElevatedButton(
                              onPressed: () {
                                MatchCubit.get(context).getCompletedMatches(
                                  user: true,
                                  more: true,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                              ),
                              child: const Text("Load more"),
                            ),
                          );
                        },
                      );
                    } else {
                      // This is a regular match item
                      var match = MatchCubit.get(context)
                          .completedMatchDetailsList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4.0, vertical: 5),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LiveDetails(match: match),
                              ),
                            );
                          },
                          child: CustomResentWidget(match: match),
                        ),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 70),
            ],
          ),
        );
      },
    );
  }
}
