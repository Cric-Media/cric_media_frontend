import 'package:cricket_app/cubits/match/match_cubit.dart';
import 'package:cricket_app/custom_widgets/custom_up_coming_matches_card.dart';
import 'package:cricket_app/custom_widgets/placeholders/upcoming_match_placeholder.dart';
import 'package:cricket_app/screens/dashbord_screen/home_tab_item/upcoming_match_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class UpComingTab extends StatefulWidget {
  const UpComingTab({Key? key}) : super(key: key);

  @override
  State<UpComingTab> createState() => _UpComingTabState();
}

class _UpComingTabState extends State<UpComingTab> {
  late AutoScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = AutoScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (MatchCubit.get(context).upcomingMatchDetailsList.isEmpty) {
        MatchCubit.get(context).getUpcomingMatches(user: true);
      }
    });
  }

  Future _scrollToIndex(int index) async {
    await controller.scrollToIndex(index,
        preferPosition: AutoScrollPosition.begin);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        children: [
          Expanded(
            child: BlocConsumer<MatchCubit, MatchState>(
              listener: (context, state) {
                if (state is MatchUpcommingSuccess) {
                  _scrollToIndex(
                      0); // Optionally scroll to the first index after loading
                }
              },
              builder: (context, state) {
                if (state is MatchUpcommingLoading) {
                  return ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) => const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                      child: UpcomingMatchPlaceholder(),
                    ),
                  );
                } else if (state is MatchUpcommingSuccess) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      await MatchCubit.get(context)
                          .getUpcomingMatches(user: true);
                    },
                    child: ListView.builder(
                      controller: controller,
                      itemCount: state.res.data.length,
                      itemBuilder: (context, index) {
                        var match = state.res.data[index];
                        return AutoScrollTag(
                          key: ValueKey(index),
                          controller: controller,
                          index: index,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        UpcomingMatchDetails(match: match),
                                  ),
                                );
                              },
                              child: Hero(
                                tag: 'match_${match.sId}',
                                child: UpCommingMachesCard(match: match),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(
                    child: Text('No upcoming matches available.'),
                  );
                }
              },
            ),
          ),
          const SizedBox(height: 70),
        ],
      ),
    );
  }
}
