import 'package:cached_network_image/cached_network_image.dart';
import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/constants/app_images.dart';
import 'package:cricket_app/constants/routes_names.dart';
import 'package:cricket_app/cubits/tournament/tournament_cubit.dart';
import 'package:cricket_app/models/match_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UpCommingMachesCard extends StatelessWidget {
  final MatchDetails? match;
  final bool? admin;
  final bool? tournament;
  const UpCommingMachesCard(
      {super.key, this.match, this.admin, this.tournament});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Card(
        color: Colors.white,
        elevation: 2,
        child: Container(
          width: screenWidth,
          decoration: const BoxDecoration(
            color: Color(0xffECECEC),
            // borderRadius: BorderRadius.circular(25),
            // Apply gradient here
          ),
          child: Row(
            children: [
              Expanded(
                  flex: 4,
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                          visible:
                              match != null && match?.tournamentInfo != null,
                          child: Column(
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
                            ],
                          ),
                        ),
                        Text(
                          match != null
                              ? "${match?.cityOrTown} City, ${match?.ground} Ground."
                              : '',
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                              fontSize: 12,
                              color: AppColor.hintColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: screenHeight * 0.015),
                        Row(
                          children: [
                            SizedBox(
                              width: 35,
                              height: 35,
                              child: match != null
                                  ? CircleAvatar(
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                        match?.team1?.image ?? '',
                                      ),
                                    )
                                  : Image.asset(AppIcons.pak),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Text(
                                match != null ? match?.team1?.name ?? '' : '',
                                style: GoogleFonts.inter(
                                    textStyle: const TextStyle(
                                  fontSize: 13,
                                  color: AppColor.blackColor,
                                  fontWeight: FontWeight.w700,
                                )),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            SizedBox(
                              width: 35,
                              height: 35,
                              child: match != null
                                  ? CircleAvatar(
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                        match?.team2?.image ?? '',
                                      ),
                                    )
                                  : Image.asset(AppIcons.afg),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Text(
                                match != null ? match?.team2?.name ?? '' : '',
                                style: GoogleFonts.inter(
                                  textStyle: const TextStyle(
                                    fontSize: 13,
                                    color: AppColor.blackColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        if (admin != null)
                          Visibility(
                            visible: admin != null,
                            child: Column(
                              children: [
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        height: 30,
                                        child: OutlinedButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                              context,
                                              startMatch,
                                              arguments: {
                                                'match': match,
                                                'refresh': true,
                                              },
                                            );
                                          },
                                          child: const Text(
                                            "Start",
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: AppColor.blueColor,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: SizedBox(
                                        height: 30,
                                        child: OutlinedButton(
                                          onPressed: () {
                                            if (tournament != null) {
                                              Navigator.pushNamed(
                                                context,
                                                addTournamentMatch,
                                                arguments: {
                                                  "tournament":
                                                      TournamentCubit.get(
                                                              context)
                                                          .tournament,
                                                  "groupId":
                                                      TournamentCubit.get(
                                                              context)
                                                          .selectedGroupId,
                                                  "totalMatches":
                                                      TournamentCubit.get(
                                                              context)
                                                          .totalMatches,
                                                  "matchType":
                                                      TournamentCubit.get(
                                                              context)
                                                          .selectedMatchType,
                                                  "match": match,
                                                },
                                              );
                                            } else {
                                              Navigator.pushNamed(
                                                  context, addMatch,
                                                  arguments: {
                                                    "match": match,
                                                  });
                                            }
                                          },
                                          child: const Text(
                                            "Edit",
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: AppColor.blueColor,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                      ],
                    ),
                  )),
              Expanded(
                flex: 3,
                child: Container(
                  color: const Color(0xffECECEC),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      // delete button
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      //     Visibility(
                      //       visible: admin != null,
                      //       child: Icon(Icons.delete, color: Colors.red),
                      //     ),
                      //   ],
                      // ),
                      Container(
                        alignment: Alignment.center,
                        width: 80,
                        height: 30,
                        decoration: BoxDecoration(
                            color: AppColor.blueColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          'Upcoming',
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Watch Live At',
                        style: TextStyle(
                            fontSize: 12,
                            color: AppColor.hintColor,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        match != null
                            ? match!.matchDateTime!.split("-").first
                            : '',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColor.blackColor,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        match != null
                            ? match!.matchDateTime!.split("-").last
                            : '',
                        style: const TextStyle(
                            fontSize: 12,
                            color: AppColor.blackColor,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
