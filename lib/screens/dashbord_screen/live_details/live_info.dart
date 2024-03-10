// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cricket_app/constent/app_color.dart';
import 'package:cricket_app/custom_widgets/grid_view_contanor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LiveInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      // Used to make the entire screen scrollable
      child: Column(
        children: [
          SizedBox(
            height: 7,
          ),
          Card(
            color: Colors.white,
            elevation: 2,
            child: Container(
              width: screenWidth,
              height: 130,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), color: Colors.white),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Afghanistan tour of Pakistan',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              fontSize: 15,
                              color: AppColor.blueColor,
                              fontWeight: FontWeight.w700)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          'Date & Time :',
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600)),
                        ),
                        Text(
                          '   Wed, 8 Jan 2024- 2:30 pm',
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                            fontSize: 14,
                            color: AppColor.hintColor,
                            fontWeight: FontWeight.w600,
                          )),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          'Match No :   ',
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600)),
                        ),
                        Text(
                          '    1st Odi',
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                            fontSize: 14,
                            color: AppColor.hintColor,
                            fontWeight: FontWeight.w600,
                          )),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Text(
                          'Toss :  \t\t\t  ',
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600)),
                        ),
                        Text(
                          '         Pakistan elect to bat',
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                            fontSize: 14,
                            color: AppColor.hintColor,
                            fontWeight: FontWeight.w600,
                          )),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          GridViewContanor(),
          Card(
            color: Colors.white,
            elevation: 2,
            child: Container(
              width: screenWidth,
              height: 130,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), color: Colors.white),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Venue',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              fontSize: 16,
                              color: AppColor.blueColor,
                              fontWeight: FontWeight.w700)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          'Stadium:\t\t\t',
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600)),
                        ),
                        Text(
                          ' Karachi cricket stadium',
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                            fontSize: 14,
                            color: AppColor.hintColor,
                            fontWeight: FontWeight.w600,
                          )),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Text(
                          'Country:\t\t\t',
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600)),
                        ),
                        Text(
                          'Pakistan',
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                            fontSize: 14,
                            color: AppColor.hintColor,
                            fontWeight: FontWeight.w600,
                          )),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Text(
                          'Province:\t\t\t',
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600)),
                        ),
                        Text(
                          'SIndh',
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                            fontSize: 14,
                            color: AppColor.hintColor,
                            fontWeight: FontWeight.w600,
                          )),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
