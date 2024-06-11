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
        } else if (state is MatchDeleteSuccess) {
          MatchCubit.get(context).getUpcomingMatches();
        }
      },
      builder: (context, state) {
        if (state is MatchUpcommingLoading) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(
              vertical: 5.0,
              horizontal: 8,
            ),
            itemBuilder: (context, index) {
              return const UpcomingMatchPlaceholder();
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
                padding: const EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 8,
                ),
                shrinkWrap: true,
                itemCount:
                    MatchCubit.get(context).upcomingMatchDetailsList.length,
                itemBuilder: (ctx, index) {
                  var match =
                      MatchCubit.get(ctx).upcomingMatchDetailsList[index];
                  return Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    confirmDismiss: (direction) {
                      return showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Are you sure?'),
                          content: const Text(
                            'Do you want to delete this match?',
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(ctx).pop(false);
                              },
                              child: const Text('No'),
                            ),
                            TextButton(
                              onPressed: () {
                                MatchCubit.get(ctx).deleteMatch(
                                  match.sId ?? '',
                                );
                                Navigator.of(ctx).pop(true);
                              },
                              child: const Text('Yes'),
                            ),
                          ],
                        ),
                      );
                    },
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
