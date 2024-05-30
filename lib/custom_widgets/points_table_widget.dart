import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/cubits/tournament/tournament_cubit.dart';
import 'package:cricket_app/models/tournament.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PointsTableWidget extends StatefulWidget {
  final String tournamentId;
  final Tournament tournament;
  const PointsTableWidget(
      {Key? key, required this.tournamentId, required this.tournament})
      : super(key: key);

  @override
  State<PointsTableWidget> createState() => _PointsTableWidgetState();
}

class _PointsTableWidgetState extends State<PointsTableWidget> {
  @override
  void initState() {
    TournamentCubit.get(context).getTournamentPoints(widget.tournamentId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Table(
            columnWidths: const {
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(1),
              3: FlexColumnWidth(1),
              4: FlexColumnWidth(1),
              5: FlexColumnWidth(1),
              6: FlexColumnWidth(2),
            },
            children: const [
              TableRow(
                decoration: BoxDecoration(color: AppColor.blueColor),
                children: [
                  Text(
                    "Pos",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text("Team",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  Text("P",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  Text("W",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  Text("L",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  Text("D",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  Text("NRR",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  Text("Pts",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                ],
              ),
            ],
          ),
          BlocConsumer<TournamentCubit, TournamentState>(
            listener: (context, state) {
              if (state is TournamentPointsSuccess) {
                TournamentCubit.get(context).pointsTable = state.response.data;
              }
            },
            builder: (context, state) {
              if (state is TournamentPointsLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TournamentPointsError) {
                return Center(child: Text(state.message));
              }
              var semiFinalTeams = widget.tournament.semiFinalTeams;

              return SingleChildScrollView(
                child: Table(
                  border: TableBorder.all(color: Colors.grey),
                  defaultColumnWidth: const IntrinsicColumnWidth(flex: 1),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  textBaseline: TextBaseline.alphabetic,
                  columnWidths: const {
                    0: FlexColumnWidth(1),
                    1: FlexColumnWidth(2),
                    2: FlexColumnWidth(1),
                    3: FlexColumnWidth(1),
                    4: FlexColumnWidth(1),
                    5: FlexColumnWidth(1),
                    6: FlexColumnWidth(2),
                  },
                  children: List.generate(
                    TournamentCubit.get(context).pointsTable.length,
                    (index) {
                      var pt = TournamentCubit.get(context).pointsTable[index];
                      bool? isQualified;
                      if (pt.finalQualifier != null) {}
                      return TableRow(
                        children: [
                          Text((index + 1).toString()),
                          // if (semiFinalTeams!.isNotEmpty)
                          // Text(
                          //     "${pt.semiQualifier == true ? 'Q' : 'E'} ${pt.team!.name.toString().substring(0, 3)}"),
                          // else
                          Text(pt.team!.name.toString().substring(0, 3)),
                          Text(pt.matchesPlayed.toString()),
                          Text(pt.wins.toString()),
                          Text(pt.losses.toString()),
                          Text(pt.draws.toString()),
                          Text(pt.netRunRate.toString()),
                          Text(pt.points.toString()),
                        ],
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
