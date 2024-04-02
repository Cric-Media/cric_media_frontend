// ignore_for_file: prefer_const_constructors

import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/constants/app_images.dart';
import 'package:cricket_app/custom_widgets/custom_contanor_trading_news.dart';
import 'package:cricket_app/custom_widgets/custom_up_coming_matches_card.dart';
import 'package:cricket_app/custom_widgets/onging_series.dart';
import 'package:cricket_app/screens/dashbord_screen/home_tab_item/matchesDetails.dart';
import 'package:cricket_app/screens/dashbord_screen/live_details/live_details.dart';
import 'package:cricket_app/screens/dashbord_screen/new_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../custom_widgets/match_details_live_card.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: screenWidth * 0.030,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Text(
                    'Matches',
                    style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            fontSize: screenWidth * 0.040,
                            color: AppColor.blackColor,
                            fontWeight: FontWeight.w800)),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LiveDetails()));
                },
                child: MatchDetailsLiveCard()),
            SizedBox(
              height: screenWidth * 0.026,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Text(
                    'Up Coming',
                    style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            fontSize: screenWidth * 0.038,
                            color: AppColor.blackColor,
                            fontWeight: FontWeight.w800)),
                  ),
                  Spacer(),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MatcheDetails()));
                },
                child: UpCommingMachesCard()),
            SizedBox(
              height: screenWidth * 0.030,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Text(
                    'Ongoing Series',
                    style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            fontSize: screenWidth * 0.038,
                            color: AppColor.blackColor,
                            fontWeight: FontWeight.w800)),
                  ),
                  Spacer(),
                ],
              ),
            ),
            SizedBox(
              height: screenWidth * 0.020,
            ),
            OngingSeries(),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Trending News',
                style: GoogleFonts.inter(
                    textStyle: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                )),
              ),
            ),
            SizedBox(
              height: 6,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NewsDetails()));
                },
                child: Card(
                  color: Colors.white,
                  elevation: 2,
                  child: Container(
                    width: screenWidth,
                    height: screenHeight * 0.38,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            //     decoration: BoxDecoration(color: Colors.amber),
                            width: screenWidth,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12)),
                            height: 170,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                AppIcons.match_1,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Pakistan and India Set to Renew Rivalry',
                            style: GoogleFonts.inter(
                                textStyle: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            )),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'The world of cricket, few matchups generate as'
                            ' much anticipation and excitement as a clash '
                            '  between Pakistan and India. Once again, these '
                            '   two cricketing giants are set to renew their historic '
                            ' rivalry, and fans across the '
                            '  globe are eagerly awaiting the showdown.',
                            style: GoogleFonts.inter(
                                textStyle: TextStyle(
                              fontSize: 12,
                              color: AppColor.grayColor,
                              fontWeight: FontWeight.w300,
                            )),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 800,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NewsDetails()));
                          },
                          child: Custom_Contanor_trading_news()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
