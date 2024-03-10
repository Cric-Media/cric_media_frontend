import 'package:cricket_app/constent/app_color.dart';
import 'package:cricket_app/constent/app_images.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomHomeCard extends StatefulWidget {
  const CustomHomeCard({super.key});

  @override
  State<CustomHomeCard> createState() => _CustomHomeCardState();
}

class _CustomHomeCardState extends State<CustomHomeCard> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Card(
      elevation: 2,
      borderOnForeground: true,
      color: Colors.white, // Example color
      child: Container(
        width: screenWidth,
        height: 195,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Afghanistan tour of Pakistan',
                    style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            fontSize: screenWidth * 0.040,
                            color: AppColor.blackColor,
                            fontWeight: FontWeight.w700)),
                  ),
                  Spacer(),
                  Container(
                    alignment: Alignment.center,
                    width: 55,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(7)),
                    child: Text(
                      'Live',
                      style: GoogleFonts.inter(
                          textStyle:
                              TextStyle(fontSize: 15, color: Colors.white)),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                '2nd ODI, At  Lahore',
                style: GoogleFonts.inter(
                    textStyle: TextStyle(
                        fontSize: 14,
                        color: AppColor.grayColor,
                        fontWeight: FontWeight.w400)),
              ),
              SizedBox(
                height: 14,
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
                  Text(
                    '320/3',
                    style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColor.blackColor)),
                  ),
                  Text(
                    '(50 Overs)',
                    style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColor.hintColor)),
                  )
                ],
              ),
              SizedBox(
                height: 13,
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
                  Text(
                    '210/6',
                    style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColor.blackColor)),
                  ),
                  Text(
                    '(46.4 Overs)',
                    style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColor.hintColor)),
                  )
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                'AFG Need by 110 runs',
                style: GoogleFonts.inter(
                    textStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColor.blueColor)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
