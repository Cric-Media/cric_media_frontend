// ignore_for_file: unused_local_variable, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_const_constructors

import 'package:cricket_app/constent/app_color.dart';
import 'package:cricket_app/constent/app_images.dart';
import 'package:cricket_app/custom_widgets/costom_text_field.dart';
import 'package:cricket_app/custom_widgets/custom_button.dart';
import 'package:cricket_app/providers/user_login_provider.dart';
import 'package:cricket_app/screens/auth_screen/forget_password/forget_password.dart';
import 'package:cricket_app/screens/auth_screen/signUp_screen/signUp_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SiginScreen extends StatelessWidget {
  const SiginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Consumer<UserLoginProvider>(
        builder: (BuildContext context, value, child) {
          return Scaffold(
            backgroundColor: Color(0XFFFBFBFB),
            appBar: AppBar(),
            // ignore: prefer_const_constructors
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: screenWidth,
                          height: screenHeight * 0.20,
                          child: Image.asset(
                            'assets/icons/logo.jpeg',
                          ),
                        ),
                        Text('Welcome In Cricket World',
                            style: GoogleFonts.inter(
                                textStyle: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: screenWidth * 0.060,
                              color: AppColor.blueColor,
                            ))),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Sign in to continue',
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                            fontSize: screenWidth * 0.043,
                            color: AppColor.grayColor,
                            fontWeight: FontWeight.w600,
                          )),
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
                          controller: value.emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            // Add more validation as needed
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Password',
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
                          isPassword: true,
                          hintText: '00000000',
                          iconImagePath: AppIcons.password,
                          controller: value.passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            // Add more validation as needed
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ForgetPassword()))
                            },
                            child: Text(
                              'Forgot Password?',
                              style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                fontSize: screenWidth * 0.035,
                                color: AppColor.blueColor,
                                fontWeight: FontWeight.w600,
                              )),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.035,
                        ),
                        CustomButton(
                          backgroundColor: AppColor.blueColor,
                          buttonText: 'LOGIN',
                          onTap: () {
                            value.userLoginApi(context);
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => DashBoardScreen()));
                          },
                        ),
                        SizedBox(
                          height: screenHeight * 0.040,
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
                    if (value.isLoading) // Show indicator if loading
                      Positioned.fill(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
