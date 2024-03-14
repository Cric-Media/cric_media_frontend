// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/constants/app_images.dart';
import 'package:cricket_app/screens/dashbord_screen/dashboard_item/profile_Screen/player_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GridViewContanor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        children: [
          Card(
            color: Colors.white,
            elevation: 2,
            child: Container(
              width: screenWidth,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 17.0),
                    child: Text(
                      'Squads',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColor.blueColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      title: Text(
                        'Afghanistan',
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      children: [
                        GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20.0,
                            mainAxisSpacing: 20.0,
                          ),
                          itemCount: 10, // Example number of items
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PlayerProfileScreen()));
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white, // Example color
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            height: 85,
                                            decoration: BoxDecoration(),
                                            child: Image.asset(
                                              AppIcons.profile2,
                                            )),
                                        Text(
                                          'Rashid Khan (vc)',
                                          style: GoogleFonts.inter(
                                              textStyle: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                          )),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Top: ',
                                              style: GoogleFonts.inter(
                                                  textStyle: TextStyle(
                                                fontSize: 11,
                                                color: AppColor.hintColor,
                                                fontWeight: FontWeight.w600,
                                              )),
                                            ),
                                            Text('Order batter',
                                                style: GoogleFonts.inter(
                                                    textStyle: TextStyle(
                                                  fontSize: 11,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                ))),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Age: ',
                                              style: GoogleFonts.inter(
                                                  textStyle: TextStyle(
                                                fontSize: 11,
                                                color: AppColor.hintColor,
                                                fontWeight: FontWeight.w600,
                                              )),
                                            ),
                                            Text(' 28y 313d',
                                                style: GoogleFonts.inter(
                                                    textStyle: TextStyle(
                                                  fontSize: 11,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                ))),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Bowling: ',
                                              style: GoogleFonts.inter(
                                                  textStyle: TextStyle(
                                                fontSize: 11,
                                                color: AppColor.hintColor,
                                                fontWeight: FontWeight.w600,
                                              )),
                                            ),
                                            Text(
                                              'Right arm Offbreak ',
                                              style: GoogleFonts.inter(
                                                  textStyle: TextStyle(
                                                fontSize: 11,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                              )),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      title: Text(
                        'Pakistan',
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      children: [
                        GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                          ),
                          itemCount: 8, // Example number of items
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PlayerProfileScreen()));
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white, // Example color
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            height: 100,
                                            decoration: BoxDecoration(),
                                            child: Image.asset(
                                              AppIcons.profile2,
                                            )),
                                        Text(
                                          'Babar Azam (c)',
                                          style: GoogleFonts.inter(
                                              textStyle: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                          )),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Top: ',
                                              style: GoogleFonts.inter(
                                                  textStyle: TextStyle(
                                                fontSize: 11,
                                                color: AppColor.hintColor,
                                                fontWeight: FontWeight.w600,
                                              )),
                                            ),
                                            Text('Order batter',
                                                style: GoogleFonts.inter(
                                                    textStyle: TextStyle(
                                                  fontSize: 11,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                ))),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Age: ',
                                              style: GoogleFonts.inter(
                                                  textStyle: TextStyle(
                                                fontSize: 11,
                                                color: AppColor.hintColor,
                                                fontWeight: FontWeight.w600,
                                              )),
                                            ),
                                            Text(' 28y 313d',
                                                style: GoogleFonts.inter(
                                                    textStyle: TextStyle(
                                                  fontSize: 11,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                ))),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Bowling: ',
                                              style: GoogleFonts.inter(
                                                  textStyle: TextStyle(
                                                fontSize: 11,
                                                color: AppColor.hintColor,
                                                fontWeight: FontWeight.w600,
                                              )),
                                            ),
                                            Text(
                                              'Right arm Offbreak ',
                                              style: GoogleFonts.inter(
                                                  textStyle: TextStyle(
                                                fontSize: 11,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                              )),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
