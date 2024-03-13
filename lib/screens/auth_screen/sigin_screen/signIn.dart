// ignore_for_file: unused_local_variable, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_const_constructors

import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/constants/app_images.dart';
import 'package:cricket_app/constants/global.dart';
import 'package:cricket_app/cubits/auth/auth_cubit.dart';
import 'package:cricket_app/custom_widgets/costom_text_field.dart';
import 'package:cricket_app/custom_widgets/custom_button.dart';
import 'package:cricket_app/screens/auth_screen/forget_password/forget_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  bool isLoading = false;

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0XFFFBFBFB),
      appBar: AppBar(),
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
                    child: Image.asset('assets/icons/logo.jpeg'),
                  ),
                  Text('Welcome In Cricket World',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: screenWidth * 0.060,
                        color: AppColor.blueColor,
                      ))),
                  SizedBox(height: 10),
                  Text(
                    'Sign in to continue',
                    style: GoogleFonts.inter(
                        textStyle: TextStyle(
                      fontSize: screenWidth * 0.043,
                      color: AppColor.grayColor,
                      fontWeight: FontWeight.w600,
                    )),
                  ),
                  SizedBox(height: screenHeight * 0.050),
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
                    hintText: 'abc@example.com',
                    iconImagePath: AppIcons.email,
                    controller: emailController,
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
                    hintText: '**********',
                    iconImagePath: AppIcons.password,
                    controller: passwordController,
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
                      BlocProvider.of<AuthCubit>(context).signin(
                        emailController.text,
                        passwordController.text,
                      );
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
                          Navigator.pushNamed(context, '/signup');
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
              BlocConsumer(
                bloc: BlocProvider.of<AuthCubit>(context),
                builder: (context, state) {
                  if (isLoading) {
                    return const Positioned.fill(
                      child: Center(
                        child: CircleAvatar(
                          radius: 25,
                          foregroundColor: AppColor.blueColor,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
                listener: (context, state) {
                  if (state is AuthLoading) {
                    isLoading = true;
                  }
                  if (state is AuthSignin) {
                    isLoading = false;
                    var userId = state.response.data.id;
                    var token = state.response.data.accessToken;
                    Global().saveUserId(userId);
                    Global().saveToken(token);

                    Navigator.of(context).pushNamed('/dashboard');
                  }
                  if (state is AuthError) {
                    isLoading = false;
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
