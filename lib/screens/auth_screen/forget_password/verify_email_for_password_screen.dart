import 'dart:async';

import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/constants/routes_names.dart';
import 'package:cricket_app/cubits/auth/auth_cubit.dart';
import 'package:cricket_app/custom_widgets/custom_button.dart';
import 'package:cricket_app/utils/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyEmailForPasswordScreen extends StatefulWidget {
  const VerifyEmailForPasswordScreen({super.key});

  @override
  State<VerifyEmailForPasswordScreen> createState() =>
      _VerifyEmailForPasswordScreenState();
}

class _VerifyEmailForPasswordScreenState
    extends State<VerifyEmailForPasswordScreen> {
  int otpTiming = 60;
  var otpController = TextEditingController();
  bool isLoading = false;
  var formKey = GlobalKey<FormState>();

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
  void dispose() {
    otpController.dispose();
    isLoading = false;
    formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Form(
                      key: formKey,
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
                            'We have sent a verification OTP to your email.',
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

                          PinCodeTextField(
                            length: 4,
                            keyboardType: TextInputType.number,
                            appContext: context,
                            obscureText: false,
                            controller: otpController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please 4 digits OTP.';
                              } else if (value.length != 4) {
                                return 'OTP must be 4 digits.';
                              }
                              return null;
                            },
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
                            animationDuration:
                                const Duration(milliseconds: 300),
                          ),
                          SizedBox(height: screenWidth * 0.040),
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
                                      BlocProvider.of<AuthCubit>(context)
                                          .sendOtpForPasswordChange();
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
                          SizedBox(height: screenWidth * 0.040),
                          CustomButton(
                            buttonText: 'Verify',
                            onTap: () {
                              BlocProvider.of<AuthCubit>(context)
                                  .verifyEmailForPassword(otpController.text);
                            },
                            widthFactor: 1,
                          ),
                        ],
                      ),
                    ),
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
                      if (state is AuthLoading || state is AuthSendOtpLoading) {
                        isLoading = true;
                      }
                      if (state is AuthSuccess) {
                        isLoading = false;
                        Navigator.pushNamed(context, changePassword);
                      }
                      if (state is AuthError) {
                        isLoading = false;
                        showSnack(context, message: state.message);
                      }
                      if (state is AuthSendOtpError) {
                        isLoading = false;
                        showSnack(context, message: state.message);
                      }
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
