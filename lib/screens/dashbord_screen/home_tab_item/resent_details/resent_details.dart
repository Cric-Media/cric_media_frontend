// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cricket_app/constent/app_color.dart';
import 'package:cricket_app/constent/app_images.dart';
import 'package:cricket_app/screens/dashbord_screen/home_tab_item/resent_details/r_info.dart';
import 'package:cricket_app/screens/dashbord_screen/home_tab_item/resent_details/recent_live.dart';
import 'package:cricket_app/screens/dashbord_screen/home_tab_item/resent_details/recent_point_table.dart';
import 'package:cricket_app/screens/dashbord_screen/home_tab_item/resent_details/recent_score_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../custom_widgets/custom_up_coming_matches_card.dart';

class recentDetails extends StatefulWidget {
  recentDetails({super.key});

  @override
  State<recentDetails> createState() => _recentDetailsState();
}

class _recentDetailsState extends State<recentDetails> {
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
            'Recent Details ',
            style: GoogleFonts.inter(
              textStyle: TextStyle(
                  fontSize: 22,
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
                UpCommingMachesCard(),
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
                    ? RecentInfo()
                    : value == 1
                        ? RecentLive()
                        : value == 2
                            ? RecentScoreCard()
                            : value == 3
                                ? RecentPointTable()
                                : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
