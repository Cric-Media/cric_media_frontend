// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, sized_box_for_whitespace

import 'package:cricket_app/constent/app_color.dart';
import 'package:cricket_app/custom_widgets/days_contanar.dart';
import 'package:cricket_app/custom_widgets/days_contanor2.dart';
import 'package:cricket_app/custom_widgets/grid_view_contanor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constent/app_images.dart';

class LiveCustomWidgt extends StatelessWidget {
  const LiveCustomWidgt({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Card(
          color: Colors.white,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            height: screenHeight * 0.15,
            width: screenWidth,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 7),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Recent Performance',
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(
                          fontSize: 14,
                          color: AppColor.blackColor,
                          fontWeight: FontWeight.w700,
                        )),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Text(
                          'Last 5 matches',
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                            fontSize: 14,
                            color: AppColor.hintColor,
                            fontWeight: FontWeight.w600,
                          )),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 35,
                        height: 35,
                        child: Image.asset('${AppIcons.pak}'),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'PAK',
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(
                          fontSize: 14,
                          color: AppColor.blackColor,
                          fontWeight: FontWeight.w600,
                        )),
                      ),
                      Spacer(),
                      Container(
                        width: 180,
                        height: 30,
                        //  decoration: BoxDecoration(color: Colors.amber),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Row(
                            children: [
                              DaysContanor(
                                text: 'L',
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              DaysContanor2(
                                text: 'W',
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              DaysContanor(
                                text: 'L',
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              DaysContanor2(
                                text: 'W',
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              DaysContanor(
                                text: 'L',
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 35,
                        height: 35,
                        child: Image.asset('${AppIcons.afg}'),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'AFG',
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(
                          fontSize: 14,
                          color: AppColor.blackColor,
                          fontWeight: FontWeight.w600,
                        )),
                      ),
                      Spacer(),
                      Container(
                        width: 180,
                        height: 30,
                        //  decoration: BoxDecoration(color: Colors.amber),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Row(
                            children: [
                              DaysContanor(
                                text: 'L',
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              DaysContanor2(
                                text: 'W',
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              DaysContanor(
                                text: 'L',
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              DaysContanor2(
                                text: 'W',
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              DaysContanor(
                                text: 'L',
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        GridViewContanor(),
        SizedBox(
          height: 4,
        ),
        Card(
          elevation: 3,
          child: Container(
            width: screenWidth,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 7),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Head To Head',
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(
                          fontSize: 14,
                          color: AppColor.blueColor,
                          fontWeight: FontWeight.w700,
                        )),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Text(
                          'Last 5 matches',
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                            fontSize: 14,
                            color: AppColor.blackColor,
                            fontWeight: FontWeight.w600,
                          )),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        child: Image.asset('${AppIcons.pak}'),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Pak won by 20 runs  ',
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(
                          fontSize: 15,
                          color: AppColor.blackColor,
                          fontWeight: FontWeight.w600,
                        )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        child: Image.asset('${AppIcons.afg}'),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Afghanistan won by 3 wickets ',
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(
                          fontSize: 15,
                          color: AppColor.blackColor,
                          fontWeight: FontWeight.w600,
                        )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        child: Image.asset('${AppIcons.pak}'),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Pak won by 20 runs   ',
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(
                          fontSize: 15,
                          color: AppColor.blackColor,
                          fontWeight: FontWeight.w600,
                        )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        child: Image.asset('${AppIcons.afg}'),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Afghanistan won by 3 wickets ',
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(
                          fontSize: 15,
                          color: AppColor.blackColor,
                          fontWeight: FontWeight.w600,
                        )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
