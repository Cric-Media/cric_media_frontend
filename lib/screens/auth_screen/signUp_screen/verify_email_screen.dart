import 'dart:async';

import 'package:cricket_app/constent/app_color.dart';
import 'package:cricket_app/constent/app_images.dart';
import 'package:cricket_app/custom_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  int otpTiming = 60;

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (otpTiming == 0) {
        timer.cancel();
      } else {
        setState(() {
          otpTiming--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Verify Email',
                    style: GoogleFonts.inter(
                        textStyle: TextStyle(
                      fontSize: screenWidth * 0.060,
                      color: AppColor.blueColor,
                      fontWeight: FontWeight.w800,
                    )),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: screenWidth * 0.040,
                ),
                Image.asset(
                  AppIcons.tornament,
                  height: 200,
                ),
                SizedBox(
                  height: screenWidth * 0.040,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'We have sent a verification OTP to your email.',
                    style: GoogleFonts.inter(
                        textStyle: TextStyle(
                      fontSize: screenWidth * 0.040,
                      color: AppColor.blackColor,
                      fontWeight: FontWeight.w400,
                    )),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: screenWidth * 0.040,
                ),
                PinCodeTextField(
                  length: 4,
                  appContext: context,
                  obscureText: false,
                  animationType: AnimationType.slide,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 60,
                    fieldWidth: 60,
                    activeFillColor: Colors.white,
                    activeColor: AppColor.blueColor,
                    inactiveColor: AppColor.textfieldColor,
                    inactiveFillColor: AppColor.textfieldColor,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                ),
                SizedBox(
                  height: screenWidth * 0.040,
                ),
                // resent otp
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Resend OTP in 00:$otpTiming',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                        fontSize: screenWidth * 0.040,
                        color: AppColor.blackColor,
                        fontWeight: FontWeight.w400,
                      )),
                      textAlign: TextAlign.center,
                    ),
                    TextButton(
                        onPressed: () {
                          // resent opt and start timer
                          setState(() {
                            otpTiming = 60;
                            startTimer();
                          });
                        },
                        child: Text(
                          'Resend OTP',
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                            fontSize: screenWidth * 0.040,
                            color: AppColor.blueColor,
                            fontWeight: FontWeight.w400,
                          )),
                          textAlign: TextAlign.center,
                        ))
                  ],
                ),
                SizedBox(
                  height: screenWidth * 0.040,
                ),
                CustomButton(
                  buttonText: 'Verify',
                  onTap: () {},
                  widthFactor: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
