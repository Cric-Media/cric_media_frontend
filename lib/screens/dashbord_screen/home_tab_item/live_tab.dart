import 'package:cricket_app/cubits/match/match_cubit.dart';
import 'package:cricket_app/custom_widgets/match_details_live_card.dart';
import 'package:cricket_app/screens/dashbord_screen/live_details/live_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LiveTab extends StatefulWidget {
  const LiveTab({super.key});

  @override
  State<LiveTab> createState() => _LiveTabState();
}

class _LiveTabState extends State<LiveTab> {
  @override
  void initState() {
    MatchCubit.get(context).getLiveMatches(user: true);
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
                                    builder: (context) => LiveDetails()));
                          },
                          child: MatchDetailsLiveCard(match: match)),
                    );
                  });
            },
          ),
        ),
        const SizedBox(height: 70)
      ]),
    );
  }
}
