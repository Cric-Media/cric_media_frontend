// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/constants/app_images.dart';
import 'package:cricket_app/custom_widgets/custom_home_card.dart';
import 'package:cricket_app/screens/dashbord_screen/live_details/live_info.dart';
import 'package:cricket_app/screens/dashbord_screen/live_details/live_live.dart';
import 'package:cricket_app/screens/dashbord_screen/live_details/live_point_table.dart';
import 'package:cricket_app/screens/dashbord_screen/live_details/live_score_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LiveDetails extends StatefulWidget {
  LiveDetails({super.key});

  @override
  State<LiveDetails> createState() => _LiveDetails();
}

class _LiveDetails extends State<LiveDetails> {
  int value = 0;
  getVlaue(int x) {
    value = x;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 4, // Number of tabs
      child: Scaffold(
        backgroundColor: Color(0XFFFBFBFB),
        appBar: AppBar(
          title: Text(
            'Live Details '.toUpperCase(),
            style: GoogleFonts.inter(
              textStyle: TextStyle(
                  fontSize: 20,
                  color: AppColor.blackColor,
                  fontWeight: FontWeight.w700),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Image.asset(
                '${AppIcons.search}',
                width: 24,
                height: 24,
              ),
            )
          ],
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                CustomHomeCard(),
                SizedBox(
                  height: 5,
                ),
                Card(
                  color: Colors.white,
                  elevation: 2,
                  child: Container(
                      width: screenWidth,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 25,
                          ),
                          InkWell(
                              onTap: () {
                                getVlaue(0);
                              },
                              child: Text(
                                'Info',
                                style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                        fontSize: 16,
                                        color: value == 0
                                            ? Colors.black
                                            : Colors.grey,
                                        fontWeight: FontWeight.w700)),
                              )),
                          SizedBox(
                            width: 30,
                          ),
                          InkWell(
                              onTap: () {
                                getVlaue(1);
                              },
                              child: Text(
                                'Live',
                                style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                        fontSize: 16,
                                        color: value == 1
                                            ? Colors.black
                                            : Colors.grey,
                                        fontWeight: FontWeight.w700)),
                              )),
                          SizedBox(
                            width: 30,
                          ),
                          InkWell(
                              onTap: () {
                                getVlaue(2);
                              },
                              child: Text(
                                'Scorecard',
                                style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                        fontSize: 16,
                                        color: value == 2
                                            ? Colors.black
                                            : Colors.grey,
                                        fontWeight: FontWeight.w700)),
                              )),
                          SizedBox(
                            width: 30,
                          ),
                          InkWell(
                              onTap: () {
                                getVlaue(3);
                              },
                              child: Text(
                                'Points Table',
                                style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                        fontSize: 16,
                                        color: value == 3
                                            ? Colors.black
                                            : Colors.grey,
                                        fontWeight: FontWeight.w700)),
                              )),
                        ],
                      )
                      // child: TabBar(
                      //   tabs: [
                      //     Tab(text: 'Info'),
                      //     Tab(text: 'Live'),
                      //     Tab(text: 'Scorecard'),
                      //     Tab(text: 'Points Table'),
                      //   ],
                      //   indicatorColor: Colors.green,
                      //   labelColor: AppColor.blackColor,
                      //   unselectedLabelColor: AppColor.grayColor,
                      // ),

                      ),
                ),
                value == 0
                    ? LiveInfo()
                    : value == 1
                        ? LiveLive()
                        : value == 2
                            ? LiveScoreCard()
                            : value == 3
                                ? LivePointTable()
                                : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
