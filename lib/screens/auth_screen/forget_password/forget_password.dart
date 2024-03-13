// ignore_for_file: prefer_const_constructors

import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/constants/app_images.dart';
import 'package:cricket_app/custom_widgets/costom_text_field.dart';
import 'package:cricket_app/custom_widgets/custom_button.dart';
import 'package:cricket_app/screens/auth_screen/forget_password/reset_password_email.dart';
import 'package:cricket_app/screens/auth_screen/signUp_screen/signUp_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final forgetPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0XFFFBFBFB),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHeight * 0.140,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Reset password',
                  style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          fontSize: screenWidth * 0.055,
                          fontWeight: FontWeight.w800,
                          color: AppColor.blueColor)),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                'Enter the email associatedwith\n'
                'your account and well send an\n'
                'with instruction to reset your\n'
                'passowrd',
                style: GoogleFonts.inter(
                    textStyle:
                        TextStyle(fontSize: 19, color: AppColor.grayColor)),
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: screenHeight * 0.050,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Email',
                  style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          fontSize: screenWidth * 0.035,
                          fontWeight: FontWeight.w800,
                          color: AppColor.blackColor)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                isPassword: false,
                hintText: 'user321@gmail.com',
                iconImagePath: AppIcons.email,
                controller: forgetPasswordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  // Add more validation as needed
                  return null;
                },
              ),
              SizedBox(
                height: screenHeight * 0.050,
              ),
              CustomButton(
                buttonText: 'Send',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResetPasswordEmail()));
                },
              ),
              SizedBox(
                height: screenHeight * 0.3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don’t have account?',
                    style: GoogleFonts.inter(
                        textStyle: TextStyle(
                      color: AppColor.hintColor,
                      fontWeight: FontWeight.w500,
                      fontSize: screenWidth * 0.038,
                    )),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()));
                    },
                    child: Text(
                      ' create a new account',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                        color: AppColor.blueColor,
                        fontWeight: FontWeight.w600,
                        fontSize: screenWidth * 0.040,
                      )),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
