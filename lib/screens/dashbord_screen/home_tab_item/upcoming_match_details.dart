import 'package:cricket_app/models/match_details.dart';
import 'package:cricket_app/screens/dashbord_screen/home_tab_item/match_Details_tabs/info.dart';
import 'package:cricket_app/screens/dashbord_screen/home_tab_item/match_Details_tabs/live.dart';
import 'package:cricket_app/screens/dashbord_screen/home_tab_item/match_Details_tabs/point_Table.dart';
import 'package:cricket_app/screens/dashbord_screen/home_tab_item/match_Details_tabs/scoreCard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/app_color.dart';
import '../../../constants/app_images.dart';
import '../../../custom_widgets/custom_up_coming_matches_card.dart';

class UpcomingMatchDetails extends StatefulWidget {
  final MatchDetails? match;
  const UpcomingMatchDetails({super.key, this.match});

  @override
  State<UpcomingMatchDetails> createState() => _UpcomingMatchDetailsState();
}

class _UpcomingMatchDetailsState extends State<UpcomingMatchDetails> {
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
        backgroundColor: const Color(0XFFFBFBFB),
        appBar: AppBar(
          title: Text(
            'Details'.toUpperCase(),
            style: GoogleFonts.inter(
              textStyle: const TextStyle(
                fontSize: 18,
                color: AppColor.blackColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Image.asset(
                AppIcons.search,
                width: 24,
                height: 24,
              ),
            )
          ],
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Column(
            children: [
              const SizedBox(height: 5),
              Hero(
                tag: widget.match?.sId.toString() ?? '',
                child: UpCommingMachesCard(match: widget.match),
              ),
              const SizedBox(height: 5),
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
                      const SizedBox(
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
                                    color:
                                        value == 0 ? Colors.black : Colors.grey,
                                    fontWeight: FontWeight.w700)),
                          )),
                      const SizedBox(width: 30),
                      InkWell(
                          onTap: () {
                            getVlaue(1);
                          },
                          child: Text(
                            'Live',
                            style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    fontSize: 16,
                                    color:
                                        value == 1 ? Colors.black : Colors.grey,
                                    fontWeight: FontWeight.w700)),
                          )),
                      const SizedBox(width: 30),
                      InkWell(
                          onTap: () {
                            getVlaue(2);
                          },
                          child: Text(
                            'Scorecard',
                            style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    fontSize: 16,
                                    color:
                                        value == 2 ? Colors.black : Colors.grey,
                                    fontWeight: FontWeight.w700)),
                          )),
                      const SizedBox(width: 30),
                      InkWell(
                          onTap: () {
                            getVlaue(3);
                          },
                          child: Text(
                            'Points Table',
                            style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    fontSize: 16,
                                    color:
                                        value == 3 ? Colors.black : Colors.grey,
                                    fontWeight: FontWeight.w700)),
                          )),
                    ],
                  ),
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
                  ? Expanded(child: Info(match: widget.match))
                  : value == 1
                      ? Expanded(child: Live(match: widget.match))
                      : value == 2
                          ? const Expanded(child: ScoreCard())
                          : value == 3
                              ? const Expanded(child: PointTable())
                              : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
