import 'package:cached_network_image/cached_network_image.dart';
import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/custom_widgets/losing_container.dart';
import 'package:cricket_app/custom_widgets/winning_container.dart';
import 'package:cricket_app/models/match_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_images.dart';

class LiveCustomWidgt extends StatelessWidget {
  final MatchDetails? match;
  const LiveCustomWidgt({super.key, this.match});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    var team1Index = match?.team1?.recentPerformance
        ?.indexWhere((element) => element.team == match?.team2?.id);

    var team2Index = match?.team2?.recentPerformance
        ?.indexWhere((element) => element.team == match?.team1?.id);

    return Column(
      children: [
        Card(
          color: Colors.white,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            width: screenWidth,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 7),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Recent Performance',
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                            fontSize: 14,
                            color: AppColor.blackColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Text(
                          'Last ${match?.team1?.recentPerformance?[team1Index!].history?.length} ${match?.team1?.recentPerformance?[team1Index!].history?.length == 1 ? "Match" : "Matches"}',
                          style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                            fontSize: 14,
                            color: AppColor.hintColor,
                            fontWeight: FontWeight.w600,
                          )),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      SizedBox(
                        width: 35,
                        height: 35,
                        child: match != null
                            ? CircleAvatar(
                                backgroundImage: CachedNetworkImageProvider(
                                  match?.team1?.image ?? '',
                                ),
                              )
                            : Image.asset(AppIcons.pak),
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
                      if (team1Index != null && team1Index != -1)
                        SizedBox(
                          width: 180,
                          height: 30,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 4.0),
                            child: Row(
                              children: match!.team1!
                                  .recentPerformance![team1Index].history!
                                  .map(
                                    (h) => h.wins == true
                                        ? Container(
                                            margin:
                                                const EdgeInsets.only(right: 4),
                                            child: const WinningContainer(
                                                text: "W"),
                                          )
                                        : Container(
                                            margin:
                                                const EdgeInsets.only(right: 4),
                                            child: const LosingContainer(
                                                text: 'L'),
                                          ),
                                  )
                                  .toList(),
                            ),
                          ),
                        )
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
                                backgroundImage: CachedNetworkImageProvider(
                                  match?.team2?.image ?? '',
                                ),
                              )
                            : Image.asset(AppIcons.afg),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        match?.team2?.name ?? '',
                        style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                          fontSize: 14,
                          color: AppColor.blackColor,
                          fontWeight: FontWeight.w600,
                        )),
                      ),
                      const Spacer(),
                      if (team2Index != null && team2Index != -1)
                        SizedBox(
                          width: 180,
                          height: 30,
                          //  decoration: BoxDecoration(color: Colors.amber),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Row(
                                children: match!.team2!
                                    .recentPerformance![team2Index].history!
                                    .map(
                                      (h) => h.wins == true
                                          ? Container(
                                              margin: const EdgeInsets.only(
                                                  right: 4),
                                              child: const WinningContainer(
                                                  text: "W"),
                                            )
                                          : Container(
                                              margin: const EdgeInsets.only(
                                                  right: 4),
                                              child: const LosingContainer(
                                                  text: 'L'),
                                            ),
                                    )
                                    .toList()),
                          ),
                        )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        // const GridViewContanor(),
        // const SizedBox(
        //   height: 4,
        // ),
        Card(
          elevation: 3,
          child: Container(
            width: screenWidth,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Head To Head',
                        style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                          fontSize: 14,
                          color: AppColor.blueColor,
                          fontWeight: FontWeight.w700,
                        )),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Text(
                          'Last ${match?.team1?.recentPerformance?[team1Index ?? 0].history?.length} ${match?.team1?.recentPerformance?[team1Index!].history?.length} ${match?.team1?.recentPerformance?[team1Index!].history?.length == 1 ? "Match" : "Matches"}',
                          style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                            fontSize: 14,
                            color: AppColor.blackColor,
                            fontWeight: FontWeight.w600,
                          )),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ...match!.team1!.recentPerformance![team1Index!].history!
                      .where((element) => element.wins == true)
                      .map(
                        (e) => Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 30,
                                height: 30,
                                child: match != null
                                    ? CircleAvatar(
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                                match?.team1?.image ?? ''),
                                      )
                                    : Image.asset(AppIcons.pak),
                              ),
                              const SizedBox(width: 15),
                              Text(
                                '${match?.team1?.name ?? ''} won by ${e.wonByRuns ?? 0} runs  ',
                                style: GoogleFonts.inter(
                                    textStyle: const TextStyle(
                                  fontSize: 15,
                                  color: AppColor.blackColor,
                                  fontWeight: FontWeight.w600,
                                )),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                  const SizedBox(height: 8),
                  ...match!.team2!.recentPerformance![team2Index!].history!
                      .where((element) => element.wins == true)
                      .map(
                        (e) => Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 30,
                                height: 30,
                                child: match != null
                                    ? CircleAvatar(
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                                match?.team2?.image ?? ''),
                                      )
                                    : Image.asset(AppIcons.pak),
                              ),
                              const SizedBox(width: 15),
                              Text(
                                '${match?.team2?.name ?? ''} won by ${e.wonByRuns ?? 0} runs  ',
                                style: GoogleFonts.inter(
                                    textStyle: const TextStyle(
                                  fontSize: 15,
                                  color: AppColor.blackColor,
                                  fontWeight: FontWeight.w600,
                                )),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
