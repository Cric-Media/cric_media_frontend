// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, sized_box_for_whitespace

import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomResentWidget extends StatelessWidget {
  CustomResentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Card(
        borderOnForeground: true,
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          width: screenWidth,
          height: 170,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            // Apply gradient here
          ),
          child: Row(
            children: [
              Expanded(
                  flex: 4,
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 17.0, top: 7),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '2nd ODI, At  Lahore',
                            style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    fontSize: 15,
                                    color: AppColor.hintColor,
                                    fontWeight: FontWeight.w500)),
                          ),
                          SizedBox(
                            height: screenHeight * 0.015,
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
                                  fontWeight: FontWeight.w700,
                                )),
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              Text(
                                '320/3',
                                style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                  fontSize: 14,
                                  color: AppColor.blackColor,
                                  fontWeight: FontWeight.w600,
                                )),
                              ),
                              Text(
                                ' (50 Overs)',
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
                            height: 15,
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
                                  fontWeight: FontWeight.w700,
                                )),
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              Text(
                                '320/3',
                                style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                  fontSize: 14,
                                  color: AppColor.blackColor,
                                  fontWeight: FontWeight.w600,
                                )),
                              ),
                              Text(
                                ' (50 Overs)',
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
                            height: 10,
                          ),
                          Text(
                            'Pak Won by 5 Wickets',
                            style: GoogleFonts.inter(
                                textStyle: TextStyle(
                              fontSize: 16,
                              color: AppColor.blueColor,
                              fontWeight: FontWeight.w700,
                            )),
                          )
                        ],
                      ),
                    ),
                  )),
              Expanded(
                  flex: 2,
                  child: Container(
                    color: Color(0xffECECEC),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 4,
                        ),
                        Image.asset(
                          AppIcons.profile2,
                          width: screenWidth,
                          height: 70,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Babar Azam',
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColor.blackColor,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Player of the \n'
                          'Match',
                          style: TextStyle(
                              fontSize: 13,
                              color: AppColor.hintColor,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
