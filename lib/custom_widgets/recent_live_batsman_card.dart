// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cricket_app/constants/app_images.dart';
import 'package:cricket_app/models/match_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecentLiveBatsmanCard extends StatelessWidget {
  final MatchDetails? match;
  const RecentLiveBatsmanCard({super.key, this.match});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 25,
                child: Image.asset(AppIcons.player2),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          match?.striker != null
                              ? "${match?.striker?.name} *"
                              : '',
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(width: 10),
                        Image.asset(
                          AppIcons.bat,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '45',
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)),
                        ),
                        Text(
                          '(44)',
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 50.0),
                child: Row(
                  children: [
                    Text(
                      '1',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Text(
                      '4',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 35,
                    ),
                    Text(
                      '44',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(
                width: 25,
                child: Image.asset(AppIcons.player2),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          match?.striker != null
                              ? "${match?.nonStriker?.name}"
                              : '',
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(width: 10),
                        Image.asset(
                          AppIcons.bat,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '45',
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)),
                        ),
                        Text(
                          '(44)',
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 50.0),
                child: Row(
                  children: [
                    Text(
                      '1',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Text(
                      '4',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 35,
                    ),
                    Text(
                      '44',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
