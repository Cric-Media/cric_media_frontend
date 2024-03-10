// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomContanor extends StatelessWidget {
  final String image;
  final String title;
  final String deuration;
  final String view;
  final String channelName;
  final String publishDate;
  CustomContanor(
      {super.key,
      required this.image,
      required this.title,
      required this.deuration,
      required this.view,
      required this.publishDate,
      required this.channelName});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      width: screenWidth,
      height: 350,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 160,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                          image: AssetImage(image), fit: BoxFit.cover)),
                  margin: EdgeInsets.only(right: 20),
                ),
                Positioned(
                  right: 30,
                  bottom: 5,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      deuration,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: screenWidth * 0.035,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 8),
              child: Text(title,
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: screenWidth * 0.035, color: Colors.black))),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                children: [
                  Text(
                    channelName,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: screenWidth * 0.025,
                        color: Colors.black.withOpacity(0.8),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 3.0, right: 5),
                    child: Text(
                      '.',
                      style: TextStyle(
                        fontSize: screenWidth * 0.025,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Text(
                    view,
                    style: TextStyle(
                      fontSize: screenWidth * 0.025,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Text(
                    'views',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: screenWidth * 0.025,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2.0),
                    child: Text(
                      '.',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: screenWidth * 0.025,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(publishDate,
                      // provider.formatRelativeTime(video
                      //     .statistics!
                      //     .publishDate),
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: screenWidth * 0.025,
                          color: Colors.black,
                        ),
                      )),
                  SizedBox(
                    width: 2,
                  ),
                ],
              ),
            )
          ]),
    );
  }
}
