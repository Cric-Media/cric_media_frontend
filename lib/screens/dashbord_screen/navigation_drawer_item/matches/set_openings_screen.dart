import 'package:cricket_app/cubits/match/match_cubit.dart';
import 'package:cricket_app/custom_widgets/custom_button.dart';
import 'package:cricket_app/models/player.dart';
import 'package:flutter/material.dart';

class SetOpeningsScreen extends StatefulWidget {
  final bool teamABatting, teamBBatting;
  final String matchId, teamAId, teamBId;
  final List<Player> squad1, squad2;
  const SetOpeningsScreen({
    Key? key,
    required this.teamABatting,
    required this.teamBBatting,
    required this.matchId,
    required this.teamAId,
    required this.teamBId,
    required this.squad1,
    required this.squad2,
  }) : super(key: key);

  @override
  State<SetOpeningsScreen> createState() => _SetOpeningsScreenState();
}

class _SetOpeningsScreenState extends State<SetOpeningsScreen> {
  @override
  void initState() {
    if (widget.teamABatting) {
      MatchCubit.get(context).teamBatting = widget.teamAId.toString();
      MatchCubit.get(context).batsmen = widget.squad1;
      MatchCubit.get(context).bowlers = widget.squad2;
    } else {
      MatchCubit.get(context).teamBatting = widget.teamBId.toString();
      MatchCubit.get(context).batsmen = widget.squad2;
      MatchCubit.get(context).bowlers = widget.squad1;
    }
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Openings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Striker",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            DropdownButton(
              value: MatchCubit.get(context).selectedStriker,
              items: MatchCubit.get(context)
                  .batsmen
                  .map((e) => DropdownMenuItem(child: Text(e.name!.toString())))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  MatchCubit.get(context).selectedStriker = value;
                });
              },
            ),
            const SizedBox(height: 20),
            const Text(
              "Non-Striker",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            DropdownButton(
              value: MatchCubit.get(context).selectedNonStriker,
              items: MatchCubit.get(context)
                  .batsmen
                  .where((element) =>
                      element.name !=
                      MatchCubit.get(context).selectedStriker?.name)
                  .map((e) => DropdownMenuItem(child: Text(e.name!.toString())))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  MatchCubit.get(context).selectedNonStriker = value;
                });
              },
            ),
            const SizedBox(height: 20),
            const Text(
              "Bowler",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            DropdownButton(
              value: MatchCubit.get(context).selectedNonStriker,
              items: MatchCubit.get(context)
                  .bowlers
                  .where((element) =>
                      element != MatchCubit.get(context).selectedStriker)
                  .map((e) => DropdownMenuItem(child: Text(e.name!.toString())))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  MatchCubit.get(context).selectedBowler = value;
                });
              },
            ),
            const SizedBox(height: 20),
            CustomButton(
              buttonText: "Continue",
              onTap: () {
                MatchCubit.get(context).setOpenings(widget.matchId);
              },
            ),
          ],
        ),
      ),
    );
  }
}
