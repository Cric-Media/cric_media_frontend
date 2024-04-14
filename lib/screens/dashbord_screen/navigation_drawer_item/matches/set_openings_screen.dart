import 'package:cricket_app/constants/routes_names.dart';
import 'package:cricket_app/cubits/match/match_cubit.dart';
import 'package:cricket_app/custom_widgets/custom_button.dart';
import 'package:cricket_app/models/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    MatchCubit.get(context).batsmen.forEach((element) {
      print(element.name);
    });
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
            DropdownButton<Player>(
              value: MatchCubit.get(context).selectedStriker,
              items: MatchCubit.get(context).batsmen.map((Player player) {
                return DropdownMenuItem<Player>(
                  value: player,
                  child: Text(player.name ?? ''),
                );
              }).toList(),
              onChanged: (Player? newValue) {
                setState(() {
                  MatchCubit.get(context).selectedStriker = newValue;
                });
              },
            ),
            const SizedBox(height: 20),
            const Text(
              "Non-Striker",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            DropdownButton<Player>(
              value: MatchCubit.get(context).selectedNonStriker,
              items: MatchCubit.get(context).batsmen.map((Player player) {
                return DropdownMenuItem<Player>(
                  value: player,
                  child: Text(player.name ?? ''),
                );
              }).toList(),
              onChanged: (Player? newValue) {
                setState(() {
                  MatchCubit.get(context).selectedNonStriker = newValue;
                });
              },
            ),
            const SizedBox(height: 20),
            const Text(
              "Bowler",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            DropdownButton<Player>(
              value: MatchCubit.get(context).selectedBowler,
              items: MatchCubit.get(context).bowlers.map((Player player) {
                return DropdownMenuItem<Player>(
                  value: player,
                  child: Text(player.name ?? ''),
                );
              }).toList(),
              onChanged: (Player? newValue) {
                setState(() {
                  MatchCubit.get(context).selectedBowler = newValue;
                });
              },
            ),
            const SizedBox(height: 20),
            BlocConsumer<MatchCubit, MatchState>(
              listener: (context, state) {
                if (state is MatchSetOpeningsSuccess) {
                  // navigate to scorer screen
                  Navigator.pushNamed(context, liveScorer);
                }
              },
              builder: (context, state) {
                if (state is MatchSetOpeningsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return CustomButton(
                  buttonText: "Continue",
                  onTap: () {
                    MatchCubit.get(context).setOpenings(widget.matchId);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
