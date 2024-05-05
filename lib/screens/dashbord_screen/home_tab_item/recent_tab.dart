import 'package:cricket_app/cubits/match/match_cubit.dart';
import 'package:cricket_app/screens/dashbord_screen/live_details/live_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../custom_widgets/custom_resent_widget.dart';

class RecentTab extends StatefulWidget {
  const RecentTab({super.key});

  @override
  State<RecentTab> createState() => _RecentTabState();
}

class _RecentTabState extends State<RecentTab> {
  @override
  void initState() {
    super.initState();
    MatchCubit.get(context).getCompletedMatches(user: true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MatchCubit, MatchState>(
      listener: (context, state) {
        if (state is MatchGetCompletedSuccess) {
          MatchCubit.get(context).completedMatchDetailsList = state.res.data;
        }
      },
      builder: (context, state) {
        if (state is MatchGetCompletedLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is MatchGetCompletedError) {
          return Center(child: Text(state.message));
        }
        return Column(
          children: [
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                  itemCount:
                      MatchCubit.get(context).completedMatchDetailsList.length,
                  itemBuilder: (context, index) {
                    var match = MatchCubit.get(context)
                        .completedMatchDetailsList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5),
                      child: InkWell(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => recentDetails()));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LiveDetails(
                                match: match,
                              ),
                            ),
                          );
                        },
                        child: CustomResentWidget(
                          match: MatchCubit.get(context)
                              .completedMatchDetailsList[index],
                        ),
                      ),
                    );
                  }),
            ),
            const SizedBox(height: 70),
          ],
        );
      },
    );
  }
}
