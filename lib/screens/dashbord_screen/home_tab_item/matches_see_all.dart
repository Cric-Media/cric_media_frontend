// ignore_for_file: prefer_const_constructors

import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/custom_widgets/match_details_live_card.dart';
import 'package:cricket_app/models/match_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MatchesSeeAll extends StatelessWidget {
  const MatchesSeeAll({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0XFFFBFBFB),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        foregroundColor: Colors.white,
        backgroundColor: AppColor.blueColor,
        title: Text(
          'All Matches',
          style: GoogleFonts.inter(
              textStyle: TextStyle(
            fontSize: screenWidth * 0.050,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          )),
        ),
        centerTitle: true,
      ),
      body: Column(children: [
        SizedBox(
          height: screenHeight * 0.020,
        ),
        Expanded(
          child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: MatchDetailsLiveCard(match: MatchDetails()),
                );
              }),
        )
      ]),
    );
  }
}
