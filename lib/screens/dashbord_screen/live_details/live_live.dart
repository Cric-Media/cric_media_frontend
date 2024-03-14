// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/custom_widgets/recent_live_batsman_card.dart';
import 'package:cricket_app/custom_widgets/recent_live_bolling_Card.dart';
import 'package:cricket_app/screens/dashbord_screen/home_tab_item/resent_details/recent_live_more_infomation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LiveLive extends StatelessWidget {
  const LiveLive({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(children: [
        Card(
          elevation: 2,
          color: Colors.white,
          child: Container(
            width: screenWidth,
            height: 75,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: Colors.white),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'AFG Loose by 100 runs',
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                color: AppColor.blueColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CRR:4.67',
                            style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    fontSize: 13,
                                    color: AppColor.hintColor,
                                    fontWeight: FontWeight.w500)),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'RR:5.67',
                            style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    fontSize: 13,
                                    color: AppColor.hintColor,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ],
                      )
                    ],
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Target: ',
                              style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                      fontSize: 13,
                                      color: AppColor.hintColor,
                                      fontWeight: FontWeight.w500)),
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              '200',
                              style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                      fontSize: 13,
                                      color: AppColor.hintColor,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total:',
                              style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                      fontSize: 13,
                                      color: AppColor.hintColor,
                                      fontWeight: FontWeight.w500)),
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              '100',
                              style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                      fontSize: 13,
                                      color: AppColor.hintColor,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Card(
          elevation: 2,
          child: Container(
            width: screenWidth,
            height: 180,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Text(
                              'Batsmen',
                              style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                fontSize: 15,
                                color: AppColor.blueColor,
                                fontWeight: FontWeight.w600,
                              )),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 50.0),
                            child: Row(
                              children: [
                                Text(
                                  '3,s',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  '5,s',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  'SR',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      RecentLiveBatsmanCard(),
                      SizedBox(
                        height: 15,
                      ),
                      RecentLiveBatsmanCard(),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0, right: 20),
                        child: Row(
                          children: [
                            Text(
                              'P’ship:',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              ' 90(100)',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text(
                              'Last Wkt: ',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'H Zazai 10 (7)',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 7,
        ),
        Card(
          elevation: 2,
          color: Colors.white,
          child: Container(
            width: screenWidth,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text(
                          'Bowling',
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                            fontSize: 15,
                            color: AppColor.blueColor,
                            fontWeight: FontWeight.w600,
                          )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 50.0),
                        child: Row(
                          children: [
                            Text(
                              'O',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Text(
                              'M',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Text(
                              'E',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Text(
                              'W',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  RecentLiveBollingCard(),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 7,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              Text(
                'Shaheen Afridi',
                style: GoogleFonts.inter(
                    textStyle: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                )),
              ),
              Spacer(),
              Text(
                '34-3(8.4)',
                style: GoogleFonts.inter(
                    textStyle: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                )),
              )
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              Text(
                'Over 45',
                style: GoogleFonts.inter(
                    textStyle: TextStyle(
                        fontSize: 14,
                        color: Color(0xff7B7B7B),
                        fontWeight: FontWeight.w500)),
              ),
              SizedBox(
                width: 15,
              ),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset.zero,
                          blurRadius: 1),
                    ]),
                child: Center(
                  child: Text(
                    '0',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset.zero,
                          blurRadius: 1),
                    ]),
                child: Center(
                  child: Text(
                    '1',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset.zero,
                          blurRadius: 1),
                    ]),
                child: Center(
                  child: Text(
                    'w',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset.zero,
                          blurRadius: 1),
                    ]),
                child: Center(
                  child: Text(
                    '0',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset.zero,
                          blurRadius: 1),
                    ]),
                child: Center(
                  child: Text(
                    '1',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset.zero,
                          blurRadius: 1),
                    ]),
                child: Center(
                  child: Text(
                    'w',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Spacer(),
              Text(
                '2 Runs',
                style: GoogleFonts.inter(
                    textStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500)),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 25,
        ),
        Container(
          height: screenHeight,
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: 9,
              itemBuilder: (context, index) {
                return RecentLiveMoreInformation();
              }),
        )
      ]),
    );
  }
}
