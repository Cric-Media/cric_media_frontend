// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScoreCard extends StatelessWidget {
  const ScoreCard({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        SizedBox(
          height: screenHight * 0.1,
        ),
        Container(
          width: screenWidth,
          height: screenHight * 0.2,
          child: Image.asset(
            AppIcons.calendar,
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(
          height: 40,
        ),
        Text(
          'Match has not Started Yet. Stay tuned!',
          style: GoogleFonts.inter(
              textStyle: TextStyle(
                  fontSize: 16,
                  color: AppColor.blueColor,
                  fontWeight: FontWeight.w400)),
        )
      ],
    );
  }
}
