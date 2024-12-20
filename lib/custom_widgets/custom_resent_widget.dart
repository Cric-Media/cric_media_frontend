import 'package:cached_network_image/cached_network_image.dart';
import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/models/match_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomResentWidget extends StatelessWidget {
  final MatchDetails? match;
  const CustomResentWidget({super.key, this.match});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    int? winningWickets = 0;
    if (match != null) {
      winningWickets = match?.winningTeam == match?.team1?.id
          ? (match!.squad1!.length - match!.team1Outs!.toInt())
          : (match!.squad2!.length - match!.team2Outs!.toInt());
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Card(
        borderOnForeground: true,
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.only(left: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          width: screenWidth,
          child: Row(
            children: [
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        match != null
                            ? match?.tournamentInfo != null
                                ? "${match?.tournamentInfo?.matchType?.toUpperCase() ?? ''}-${match?.tournamentInfo?.tournament?.seriesName} of ${match?.tournamentInfo?.tournament?.seriesLocation}"
                                : ""
                            : '',
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                            fontSize: 12,
                            color: AppColor.blueColor,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
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
                          const SizedBox(width: 4),
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
                          const SizedBox(width: 4),
                          Text(
                            "(${match?.team1Overs}/${match?.team1Balls})",
                          ),
                        ],
                      ),
                      if (match?.winningTeam != null)
                        const SizedBox(height: 16),
                      if (match?.winningTeam != null)
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
                          Visibility(
                            visible: match?.matchDropped?.dropped != true ||
                                match?.manOfTheMatch != null,
                            child: CachedNetworkImage(
                                imageUrl: match?.manOfTheMatch?.imageUrl ?? "",
                                height: 80,
                                width: 80,
                                errorWidget: (context, url, error) =>
                                    const Icon(
                                      Icons.image_outlined,
                                      color: Colors.red,
                                    )),
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
                          if (match?.matchDropped?.dropped != true)
                            const Text(
                              "Player of the match",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          else
                            const Text(
                              "Match Dropped",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
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
