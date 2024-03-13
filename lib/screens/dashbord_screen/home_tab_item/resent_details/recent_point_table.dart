// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cricket_app/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecentPointTable extends StatelessWidget {
  const RecentPointTable({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        SizedBox(
          height: screenHeight * 0.010,
        ),
        Container(
          width: screenWidth,
          height: screenHeight * 0.38,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0, 2), // Adjust the offset as needed
                blurRadius: 5, // Adjust the blurRadius as needed
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                width: screenWidth,
                height: 70,
                decoration: BoxDecoration(color: AppColor.blueColor),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Pos',
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        )),
                      ),
                      SizedBox(
                        width: 26,
                      ),
                      Text(
                        'Team',
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        )),
                      ),
                      SizedBox(
                        width: 26,
                      ),
                      Text(
                        'P',
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        )),
                      ),
                      SizedBox(
                        width: 26,
                      ),
                      Text(
                        'W',
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        )),
                      ),
                      SizedBox(
                        width: 26,
                      ),
                      Text(
                        'L',
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        )),
                      ),
                      SizedBox(
                        width: 26,
                      ),
                      Text(
                        'T',
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        )),
                      ),
                      SizedBox(
                        width: 26,
                      ),
                      Text(
                        'NRR',
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        )),
                      ),
                      SizedBox(
                        width: 26,
                      ),
                      Text(
                        'Pts',
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        )),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 19,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      '1',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      )),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Text(
                      'pak',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      )),
                    ),
                    SizedBox(
                      width: 35,
                    ),
                    Text(
                      '4',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      '5',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      '0',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      '2.22',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      '2%',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      '10',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      '1',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      )),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Text(
                      'pak',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      )),
                    ),
                    SizedBox(
                      width: 35,
                    ),
                    Text(
                      '4',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      '5',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      '0',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      '2.22',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      '2%',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      '10',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      '1',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      )),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Text(
                      'pak',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      )),
                    ),
                    SizedBox(
                      width: 35,
                    ),
                    Text(
                      '4',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      '5',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      '0',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      '2.22',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      '2%',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      '10',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      '1',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      )),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Text(
                      'pak',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      )),
                    ),
                    SizedBox(
                      width: 35,
                    ),
                    Text(
                      '4',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      '5',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      '0',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      '2.22',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      '2%',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      '10',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      '1',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      )),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Text(
                      'pak',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      )),
                    ),
                    SizedBox(
                      width: 35,
                    ),
                    Text(
                      '4',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      '5',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      '0',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      '2.22',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      '2%',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      '10',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
