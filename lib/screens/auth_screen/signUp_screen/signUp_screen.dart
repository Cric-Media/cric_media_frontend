import 'package:cricket_app/constent/app_color.dart';
import 'package:cricket_app/constent/app_images.dart';
import 'package:cricket_app/cubits/auth/auth_cubit.dart';
import 'package:cricket_app/custom_widgets/costom_text_field.dart';
import 'package:cricket_app/custom_widgets/custom_button.dart';
import 'package:cricket_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final user = User();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0XFFFBFBFB),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Form(
                child: Column(
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
                    const SizedBox(height: 10),
                    CustomTextField(
                      isPassword: false,
                      hintText: 'John Doe',
                      iconImagePath: AppIcons.user,
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        // Add more validation as needed
                        return null;
                      },
                    ),
                    const SizedBox(
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
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      isPassword: false,
                      hintText: 'user321@gmail.com',
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
                    const SizedBox(height: 15),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Phone',
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            fontSize: screenWidth * 0.035,
                            fontWeight: FontWeight.w800,
                            color: AppColor.blackColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: phoneController,
                      isPassword: false,
                      hintText: '+923000000000',
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
                    const SizedBox(height: 15),
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
                    const SizedBox(height: 10),
                    CustomTextField(
                      isPassword: true,
                      hintText: '**********',
                      iconImagePath: AppIcons.password,
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        // Add more password validation as needed
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
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
                    const SizedBox(height: 10),
                    CustomTextField(
                      isPassword: true,
                      hintText: '**********',
                      iconImagePath: AppIcons.password,
                      validator: (confirmPassword) {
                        if (confirmPassword == null ||
                            confirmPassword.isEmpty) {
                          return 'Please confirm your password';
                        } else if (confirmPassword != passwordController) {
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
                          user.name = nameController.text;
                          user.email = emailController.text;
                          user.phoneNumber = phoneController.text;
                          user.password = passwordController.text;

                          context.read<AuthCubit>().signup(user);
                        },
                        buttonText: 'Create Account'),
                    SizedBox(height: screenHeight * 0.045),
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
                        )
                      ],
                    )
                  ],
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
                  if (state is AuthLoading) {
                    isLoading = true;
                  }
                  if (state is AuthSignup) {
                    Navigator.pushNamed(context, '/signin');
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