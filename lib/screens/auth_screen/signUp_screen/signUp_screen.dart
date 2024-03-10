// ignore_for_file: prefer_const_constructors

import 'package:cricket_app/constent/app_color.dart';
import 'package:cricket_app/constent/app_images.dart';
import 'package:cricket_app/custom_widgets/custom_button.dart';
import 'package:cricket_app/providers/registration_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../custom_widgets/costom_text_field.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(child: Consumer<RegistrationProvider>(
      builder: (BuildContext context, value, child) {
        return Scaffold(
          backgroundColor: Color(0XFFFBFBFB),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: screenHeight * 0.1,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Create Account',
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
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Name',
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
                        hintText: 'abbas khan',
                        iconImagePath: AppIcons.user,
                        controller: value.usernameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }
                          // Add more validation as needed
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 15,
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
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Phone',
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
                        controller: value.phoneController,
                        isPassword: false,
                        hintText: '+9234433223234',
                        iconImagePath:
                            AppIcons.phone, //  controller: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          // Add more validation as needed
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Password',
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                              fontSize: screenWidth * 0.035,
                              fontWeight: FontWeight.w800,
                              color: AppColor.blackColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      CustomTextField(
                        isPassword: true,
                        hintText: '0000000000',
                        iconImagePath: AppIcons.password,
                        controller: value.passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          // Add more password validation as needed
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Confirm Password',
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                              fontSize: screenWidth * 0.035,
                              fontWeight: FontWeight.w800,
                              color: AppColor.blackColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      CustomTextField(
                        isPassword: true,
                        hintText: '00000000000',
                        iconImagePath: AppIcons.password,
                        validator: (valuess) {
                          if (valuess == null || valuess.isEmpty) {
                            return 'Please confirm your password';
                          } else if (valuess != value.passwordController) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: screenHeight * 0.055,
                      ),
                      CustomButton(
                          backgroundColor: AppColor.blueColor,
                          onTap: () {
                            value.userRegisterApi(context);
                            value.setLoading(true);
                            //  value.printdetails();
                          },
                          buttonText: 'Create Accuent'),
                      SizedBox(
                        height: screenHeight * 0.045,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            ' Already have a account?',
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
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                ' Login',
                                style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                  color: AppColor.blueColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: screenWidth * 0.040,
                                )),
                              ),
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
    ));
  }
}
