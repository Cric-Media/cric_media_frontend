import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/constants/app_images.dart';
import 'package:cricket_app/models/match_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MatchDetailsLiveCard extends StatelessWidget {
  final MatchDetails matchDetails;
  const MatchDetailsLiveCard({super.key, required this.matchDetails});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Card(
      elevation: 2,
      borderOnForeground: true,
      color: Colors.white,
      child: Container(
        width: screenWidth,
        height: 195,
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
                  // Text(
                  //   'Afghanistan tour of Pakistan',
                  //   style: GoogleFonts.inter(
                  //       textStyle: TextStyle(
                  //           fontSize: screenWidth * 0.040,
                  //           color: AppColor.blackColor,
                  //           fontWeight: FontWeight.w700)),
                  // ),
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
                              fontSize: 15, color: Colors.white)),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 3),
              Text(
                'At ${matchDetails.cityOrTown}',
                style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                        fontSize: 14,
                        color: AppColor.grayColor,
                        fontWeight: FontWeight.w400)),
              ),
              const SizedBox(
                height: 14,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 35,
                    height: 35,
                    child: Image.asset(AppIcons.pak),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    'PAK',
                    style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                      fontSize: 14,
                      color: AppColor.blackColor,
                      fontWeight: FontWeight.w600,
                    )),
                  ),
                  const Spacer(),
                  Text(
                    '${matchDetails.team1Score}/${matchDetails.team1Outs}',
                    style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColor.blackColor)),
                  ),
                  Text(
                    '(${matchDetails.team1Overs}.${matchDetails.team1Balls} Overs)',
                    style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColor.hintColor)),
                  )
                ],
              ),
              const SizedBox(
                height: 13,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 35,
                    height: 35,
                    child: Image.asset(AppIcons.afg),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    'AFG',
                    style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                      fontSize: 14,
                      color: AppColor.blackColor,
                      fontWeight: FontWeight.w600,
                    )),
                  ),
                  const Spacer(),
                  Text(
                    '${matchDetails.team2Score}/${matchDetails.team2Outs}',
                    style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColor.blackColor)),
                  ),
                  Text(
                    '(${matchDetails.team2Overs}.${matchDetails.team2Balls} Overs)',
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColor.hintColor),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                'AFG Need by 110 runs',
                style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColor.blueColor)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
