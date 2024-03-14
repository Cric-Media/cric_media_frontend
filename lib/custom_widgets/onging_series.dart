import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OngingSeries extends StatelessWidget {
  const OngingSeries({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Card(
            elevation: 1,
            color: Colors.white,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: Image.asset(AppIcons.cup2),
                title: Text(
                  'ICC World Cup',
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                subtitle: Text(
                  'India 2023',
                  style: GoogleFonts.inter(
                      textStyle: TextStyle(
                    fontSize: 12,
                    color: AppColor.grayColor,
                    fontWeight: FontWeight.w400,
                  )),
                ),
              ),
            ),
          ),
          Card(
            color: Colors.white,
            elevation: 1,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: Image.asset(AppIcons.cup2),
                title: Text(
                  'South Africa vs England',
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                subtitle: Text(
                  'Pakistan',
                  style: GoogleFonts.inter(
                      textStyle: TextStyle(
                    fontSize: 12,
                    color: AppColor.grayColor,
                    fontWeight: FontWeight.w400,
                  )),
                ),
              ),
            ),
          ),
          Card(
            elevation: 1,
            color: Colors.white,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: Image.asset(AppIcons.cup2),
                title: Text(
                  'Pakistan vs India',
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                subtitle: Text(
                  'Pakistan',
                  style: GoogleFonts.inter(
                      textStyle: TextStyle(
                    fontSize: 12,
                    color: AppColor.grayColor,
                    fontWeight: FontWeight.w400,
                  )),
                ),
              ),
            ),
          ),
          Card(
            elevation: 1,
            color: Colors.white,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: Image.asset(AppIcons.cup2),
                title: Text(
                  'Afghanistan vs England',
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                subtitle: Text(
                  'Pakistan',
                  style: GoogleFonts.inter(
                      textStyle: TextStyle(
                    fontSize: 12,
                    color: AppColor.grayColor,
                    fontWeight: FontWeight.w400,
                  )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
