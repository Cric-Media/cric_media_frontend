import 'package:cached_network_image/cached_network_image.dart';
import 'package:cricket_app/models/match_details.dart';
import 'package:flutter/material.dart';

class CustomResentWidget extends StatelessWidget {
  final MatchDetails? match;
  const CustomResentWidget({super.key, this.match});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    var winningWickets = match?.winningTeam == match?.team1?.id
        ? (match!.squad1!.length - match!.team1Outs!.toInt())
        : (match!.squad2!.length - match!.team2Outs!.toInt());
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Card(
        borderOnForeground: true,
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          width: screenWidth,
          // height: screenHeight * 0.15,
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    children: [
                      // Team 1
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: CachedNetworkImageProvider(
                              match?.team1?.image ?? '',
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            match?.team1?.name.toString() ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "${match?.team1Score}/${match?.team1Outs}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "(${match?.team2Overs}/${match?.team2Balls})",
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: CachedNetworkImageProvider(
                              match?.team2?.image ?? '',
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            match?.team2?.name.toString() ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "${match?.team2Score}/${match?.team2Outs}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "(${match?.team1Overs}/${match?.team1Balls})",
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      if (match?.winningTeam == match?.team1?.id)
                        Text(
                          "${match?.team1?.name} won by $winningWickets wickets",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.grey.shade300,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CachedNetworkImage(
                            imageUrl: match?.manOfTheMatch?.imageUrl ?? "",
                            height: 100,
                          ),
                          Text(
                            match?.manOfTheMatch?.name ?? "",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "Player of the match",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
