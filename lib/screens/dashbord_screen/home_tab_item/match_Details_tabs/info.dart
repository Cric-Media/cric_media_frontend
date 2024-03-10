// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cricket_app/constent/app_color.dart';
import 'package:cricket_app/custom_widgets/grid_view_contanor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Info extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      // Used to make the entire screen scrollable
      child: Column(
        children: [
          GridViewContanor(),
          Card(
            elevation: 3,
            color: Colors.white,
            child: Container(
              width: screenWidth,
              height: screenHeight * 0.22,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 7,
                    ),
                    Row(
                      children: [
                        Text(
                          'Series',
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                            fontSize: 16,
                            color: AppColor.blueColor,
                            fontWeight: FontWeight.w700,
                          )),
                        ),
                        Spacer(),
                        Text('02 Nov 2023, 2:00 pm',
                            style: GoogleFonts.inter(
                                textStyle: TextStyle(
                              fontSize: 15,
                              color: AppColor.grayColor,
                              fontWeight: FontWeight.w600,
                            ))),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text('Super 50 Cup 2023',
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(
                          fontSize: 14,
                          color: AppColor.grayColor,
                          fontWeight: FontWeight.w600,
                        ))),
                    SizedBox(
                      height: 14,
                    ),
                    Text('Match',
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(
                          fontSize: 16,
                          color: AppColor.blackColor,
                          fontWeight: FontWeight.w800,
                        ))),
                    SizedBox(
                      height: 8,
                    ),
                    Text('24th ODI',
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(
                          fontSize: 14,
                          color: AppColor.grayColor,
                          fontWeight: FontWeight.w600,
                        ))),
                    SizedBox(
                      height: 8,
                    ),
                    Text('Venue',
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(
                          fontSize: 16,
                          color: AppColor.blackColor,
                          fontWeight: FontWeight.w800,
                        ))),
                    SizedBox(
                      height: 8,
                    ),
                    Text('Karachi Stadium, Pakistan',
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(
                          fontSize: 14,
                          color: AppColor.grayColor,
                          fontWeight: FontWeight.w600,
                        ))),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
