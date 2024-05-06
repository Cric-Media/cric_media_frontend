import 'package:cached_network_image/cached_network_image.dart';
import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/models/match_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MatchDetailsLiveCard extends StatelessWidget {
  final MatchDetails? match;
  const MatchDetailsLiveCard({super.key, this.match});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    var winningTeam;
    var winningWickets;
    if (match != null) {
      winningTeam = match?.team1?.id == match?.winningTeam
          ? match?.team1?.name
          : match?.team2?.name;
      winningWickets = match?.team1?.id == match?.winningTeam
          ? (match!.squad1!.length.toInt() - match!.team1Outs!.toInt())
          : (match!.squad2!.length.toInt() - match!.team2Outs!.toInt());
    }

    return Card(
      elevation: 2,
      borderOnForeground: true,
      color: Colors.white,
      child: Container(
        width: screenWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    match == null ? 'City' : 'At ${match?.cityOrTown}',
                    style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                            fontSize: 14,
                            color: AppColor.grayColor,
                            fontWeight: FontWeight.w400)),
                  ),
                  const Spacer(),
                  Container(
                    alignment: Alignment.center,
                    width: 55,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(7)),
                    child: Text(
                      'Live',
                      style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 35,
                    height: 35,
                    child: match == null
                        ? Image.asset("assets/image/pak1.png")
                        : CircleAvatar(
                            backgroundImage: CachedNetworkImageProvider(
                              match?.team1?.image ?? '',
                            ),
                          ),
                  ),
                  const SizedBox(width: 15),
                  Text(
                    match?.team1?.name ?? '',
                    style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                      fontSize: 14,
                      color: AppColor.blackColor,
                      fontWeight: FontWeight.w600,
                    )),
                  ),
                  const Spacer(),
                  Text(
                    match == null
                        ? '0/0'
                        : '${match?.team1Score}/${match?.team1Outs}',
                    style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColor.blackColor)),
                  ),
                  Text(
                    match == null
                        ? ' (0.0 Overs)'
                        : ' (${match?.team2Overs}.${match?.team2Balls} Overs)',
                    style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColor.hintColor)),
                  )
                ],
              ),
              const SizedBox(height: 13),
              Row(
                children: [
                  SizedBox(
                    width: 35,
                    height: 35,
                    child: match == null
                        ? Image.asset("assets/image/pak1.png")
                        : CircleAvatar(
                            backgroundImage: CachedNetworkImageProvider(
                              match?.team2?.image ?? '',
                            ),
                          ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    match?.team2?.name ?? '',
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        fontSize: 14,
                        color: AppColor.blackColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    match == null
                        ? '0/0'
                        : '${match?.team2Score}/${match?.team2Outs}',
                    style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColor.blackColor)),
                  ),
                  Text(
                    match == null
                        ? ' (0/0 Overs)'
                        : ' (${match?.team1Overs}.${match?.team1Balls} Overs)',
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColor.hintColor,
                      ),
                    ),
                  )
                ],
              ),
              if (match != null)
                Visibility(
                  visible: match!.matchStatus! > 1,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 12,
                      ),
                      Center(
                        child: Text(
                          '$winningTeam won by $winningWickets wickets',
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: AppColor.blueColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
