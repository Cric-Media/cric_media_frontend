// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, unnecessary_string_interpolations

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/constants/app_images.dart';
import 'package:cricket_app/constants/routes_names.dart';
import 'package:cricket_app/models/match_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UpCommingMachesCard extends StatelessWidget {
  final MatchDetails? match;
  final bool? admin;
  const UpCommingMachesCard({super.key, this.match, this.admin});

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
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(25),
            // Apply gradient here
          ),
          child: Row(
            children: [
              Expanded(
                  flex: 4,
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 17.0, top: 7),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text(
                          //   'Asia Cup 2023',
                          //   style: GoogleFonts.inter(
                          //       textStyle: TextStyle(
                          //           fontSize: 15,
                          //           color: AppColor.hintColor,
                          //           fontWeight: FontWeight.w500)),
                          // ),
                          SizedBox(height: screenHeight * 0.015),
                          Row(
                            children: [
                              Container(
                                width: 35,
                                height: 35,
                                child: match != null
                                    ? CircleAvatar(
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                          match!.team1!.image!,
                                        ),
                                      )
                                    : Image.asset('${AppIcons.pak}'),
                              ),
                              SizedBox(width: 15),
                              Expanded(
                                child: Text(
                                  match != null ? match!.team1!.name! : 'PAK',
                                  style: GoogleFonts.inter(
                                      textStyle: TextStyle(
                                    fontSize: 14,
                                    color: AppColor.blackColor,
                                    fontWeight: FontWeight.w700,
                                  )),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          Row(
                            children: [
                              Container(
                                width: 35,
                                height: 35,
                                child: match != null
                                    ? CircleAvatar(
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                          match!.team2!.image!,
                                        ),
                                      )
                                    : Image.asset('${AppIcons.afg}'),
                              ),
                              SizedBox(width: 15),
                              Expanded(
                                child: Text(
                                  match != null ? match!.team2!.name! : 'AFG',
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                      fontSize: 14,
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
                          admin == null
                              ? SizedBox.shrink()
                              : Expanded(
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        startMatch,
                                        arguments: {'match': match},
                                      );
                                    },
                                    child: Text(
                                      "Start Match",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: AppColor.blueColor,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                )
                        ],
                      ),
                    ),
                  )),
              Expanded(
                  flex: 3,
                  child: Container(
                    color: Color(0xffECECEC),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 50, top: 7),
                          alignment: Alignment.center,
                          width: 80,
                          height: 30,
                          decoration: BoxDecoration(
                              color: AppColor.blueColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            'Upcoming',
                            style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    fontSize: 13, color: Colors.white)),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Watch Live At',
                          style: TextStyle(
                              fontSize: 15,
                              color: AppColor.hintColor,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          match != null
                              ? match!.matchDateTime!.split("-").first
                              : '6:00 pm',
                          style: TextStyle(
                              fontSize: 13,
                              color: AppColor.blackColor,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 7),
                        Text(
                          match != null
                              ? match!.matchDateTime!.split("-").last
                              : '09-04-2023',
                          style: TextStyle(
                              fontSize: 14,
                              color: AppColor.blackColor,
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
