// ignore_for_file: prefer_const_constructors

import 'package:cricket_app/constent/app_color.dart';
import 'package:cricket_app/custom_widgets/custom_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPasswordEmail extends StatelessWidget {
  const ResetPasswordEmail({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0XFFFBFBFB),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: screenHeight * 0.2,
                ),
                Image.asset(
                  'assets/icons/mail.png',
                  width: screenWidth,
                  height: 180,
                ),
                SizedBox(
                  height: screenHeight * 0.035,
                ),
                Text(
                  'Check your mail',
                  style: GoogleFonts.inter(
                      textStyle: TextStyle(
                    fontSize: screenWidth * 0.055,
                    color: AppColor.blueColor,
                    fontWeight: FontWeight.w800,
                  )),
                ),
                SizedBox(
                  height: screenHeight * 0.030,
                ),
                Text(
                  'We have sent a password recover\ninstruction to your email.',
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                        fontSize: screenWidth * 0.035,
                        color: AppColor.hintColor.withOpacity(0.7),
                        fontWeight: FontWeight.w500),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: screenHeight * 0.035,
                ),
                CustomButton(buttonText: 'Open email app'),
              ],
            ),
          ),
          Spacer(), // Pushes the row to the bottom
          Padding(
              // Added padding to match your design aesthetics
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text.rich(
                TextSpan(
                  text: 'Did not receive the email? Check your spam filter,\n',
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      color: AppColor.grayColor,
                      fontWeight: FontWeight.w500,
                      fontSize: screenWidth * 0.035,
                    ),
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'or try another email address',
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          color: AppColor.blueColor,
                          fontWeight: FontWeight.w700,
                          fontSize: screenWidth * 0.033,
                        ),
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Add your tap action here
                        },
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              )),
          SizedBox(
              height: screenHeight *
                  0.03), // Add some padding at the bottom if needed
        ],
      ),
    );
  }
}
