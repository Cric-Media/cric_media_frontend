// ignore_for_file: use_build_context_synchronously

import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/constants/app_images.dart';
import 'package:cricket_app/constants/global.dart';
import 'package:cricket_app/constants/routes_names.dart';
import 'package:cricket_app/cubits/auth/auth_cubit.dart';
import 'package:cricket_app/custom_widgets/costom_text_field.dart';
import 'package:cricket_app/custom_widgets/custom_button.dart';
import 'package:cricket_app/utils/snackbars.dart';
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
  var formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    isLoading = false;
    emailController.dispose();
    passwordController.dispose();
    formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0XFFFBFBFB),
      appBar: AppBar(),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: screenWidth,
                      height: screenHeight * 0.20,
                      child: Image.asset(AppIcons.logo),
                    ),
                    Text('Welcome In Cricket World',
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: screenWidth * 0.060,
                          color: AppColor.blueColor,
                        ))),
                    const SizedBox(height: 10),
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
                    const SizedBox(
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
                    const SizedBox(
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
                    const SizedBox(
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
                    const SizedBox(
                      height: 15,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () =>
                            Navigator.pushNamed(context, forgetPassword),
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
                        if (!formKey.currentState!.validate()) {
                          return;
                        }
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
                            Navigator.pushNamed(context, signup);
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
                  listener: (context, state) async {
                    if (state is AuthLoading) {
                      isLoading = true;
                    }
                    if (state is AuthSignin) {
                      isLoading = false;
                      var userId = state.response.data.id;
                      var token = state.response.data.accessToken;
                      await Global().deleteAllUserInfo();
                      await Global().saveUserId(userId);
                      await Global().saveToken(token);

                      Navigator.pushReplacementNamed(context, dashboard);
                    }
                    if (state is AuthError) {
                      isLoading = false;
                      showSnack(context, message: state.message);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
