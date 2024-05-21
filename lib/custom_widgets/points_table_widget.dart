import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/cubits/tournament/tournament_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PointsTableWidget extends StatefulWidget {
  final String tournamentId;
  const PointsTableWidget({Key? key, required this.tournamentId})
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
              0: FlexColumnWidth(2),
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
                    "Position",
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
              return SingleChildScrollView(
                child: Table(
                  border: TableBorder.all(color: Colors.grey),
                  defaultColumnWidth: const IntrinsicColumnWidth(flex: 1),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  textBaseline: TextBaseline.alphabetic,
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(2),
                    2: FlexColumnWidth(1),
                    3: FlexColumnWidth(1),
                    4: FlexColumnWidth(1),
                    5: FlexColumnWidth(1),
                    6: FlexColumnWidth(2),
                  },
                  children: List.generate(
                    TournamentCubit.get(context).pointsTable.length,
                    (index) => TableRow(
                      children: [
                        Text((index + 1).toString()),
                        Text(
                          TournamentCubit.get(context)
                              .pointsTable[index]
                              .team!
                              .name
                              .toString()
                              .substring(0, 3),
                        ),
                        Text(TournamentCubit.get(context)
                            .pointsTable[index]
                            .matchesPlayed
                            .toString()),
                        Text(TournamentCubit.get(context)
                            .pointsTable[index]
                            .wins
                            .toString()),
                        Text(TournamentCubit.get(context)
                            .pointsTable[index]
                            .losses
                            .toString()),
                        Text(TournamentCubit.get(context)
                            .pointsTable[index]
                            .draws
                            .toString()),
                        Text(TournamentCubit.get(context)
                            .pointsTable[index]
                            .netRunRate
                            .toString()),
                        Text(TournamentCubit.get(context)
                            .pointsTable[index]
                            .points
                            .toString()),
                      ],
                    ),
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
