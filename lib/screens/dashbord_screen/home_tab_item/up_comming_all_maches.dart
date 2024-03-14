// ignore_for_file: prefer_const_constructors

import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/custom_widgets/custom_up_coming_matches_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UpComingAllMatches extends StatelessWidget {
  const UpComingAllMatches({super.key});

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
          ' UpComing Matches',
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
                  child: UpCommingMachesCard(),
                );
              }),
        )
      ]),
    );
  }
}
