import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/cubits/tournament/tournament_cubit.dart';
import 'package:cricket_app/custom_widgets/points_table_widget.dart';
import 'package:cricket_app/models/match_details.dart';
import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/tornaments/tournament_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MatchPointsTable extends StatefulWidget {
  final MatchDetails? match;
  const MatchPointsTable({Key? key, this.match}) : super(key: key);

  @override
  State<MatchPointsTable> createState() => _MatchPointsTableState();
}

class _MatchPointsTableState extends State<MatchPointsTable> {
  @override
  void initState() {
    TournamentCubit.get(context)
        .getTournament(widget.match?.tournamentInfo?.tournament?.sId ?? '');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TournamentCubit, TournamentState>(
      listener: (context, state) {
        if (state is TournamentGetSuccess) {
          TournamentCubit.get(context).tournament = state.response.data;
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            if (widget.match?.tournamentInfo != null &&
                widget.match?.tournamentInfo?.tournament != null)
              Column(
                children: [
                  if (widget.match!.tournamentInfo!.group == null)
                    PointsTableWidget(
                      tournamentId:
                          widget.match?.tournamentInfo?.tournament?.sId ?? '',
                      tournament: widget.match!.tournamentInfo!.tournament!,
                    )
                  else
                    Groups(
                      tournamentId:
                          widget.match?.tournamentInfo?.tournament?.sId ?? '',
                      isAdmin: false,
                    )
                ],
              )
            else
              const Center(
                child: Text(
                  "Points Table is only available for tournament matches",
                  style: TextStyle(
                    color: AppColor.blackColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
          ],
        );
      },
    );
  }
}
