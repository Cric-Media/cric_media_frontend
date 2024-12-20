import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/constants/app_images.dart';
import 'package:cricket_app/constants/routes_names.dart';
import 'package:cricket_app/cubits/auth/auth_cubit.dart';
import 'package:cricket_app/custom_widgets/costom_text_field.dart';
import 'package:cricket_app/custom_widgets/custom_button.dart';
import 'package:cricket_app/utils/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  var passwordController = TextEditingController();
  bool isLoading = false;
  var formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    passwordController.dispose();
    isLoading = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0XFFFBFBFB),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
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
                        AppIcons.startmatch,
                        width: screenWidth,
                        height: 180,
                      ),
                      SizedBox(height: screenHeight * 0.035),
                      Text(
                        'Change Password',
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
                        'You can now reset your password with valid password format',
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
                      CustomTextField(
                        hintText: "**********",
                        controller: passwordController,
                        isPassword: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          // Add more validation as needed
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              // Spacer(),
              const SizedBox(height: 16),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthSuccess) {
                    Navigator.pushReplacementNamed(context, signin);
                  }
                  if (state is AuthError) {
                    showSnack(context, message: state.message);
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return CustomButton(
                    buttonText: "Continue",
                    onTap: () {
                      if (!formKey.currentState!.validate()) {
                        return;
                      }
                      BlocProvider.of<AuthCubit>(context)
                          .changePassword(passwordController.text);
                    },
                  );
                },
              ),
              SizedBox(height: screenHeight * 0.2),
            ],
          ),
        ),
      ),

      //   Stack(
      //     children: [

      //       BlocConsumer(
      //         bloc: BlocProvider.of<AuthCubit>(context),
      //         builder: (context, state) {
      //           if (isLoading) {
      //             return const Positioned.fill(
      //               child: Center(
      //                 child: CircleAvatar(
      //                   radius: 25,
      //                   foregroundColor: AppColor.blueColor,
      //                   child: CircularProgressIndicator(),
      //                 ),
      //               ),
      //             );
      //           } else {
      //             return const SizedBox.shrink();
      //           }
      //         },
      //         listener: (context, state) {
      //           if (state is AuthLoading) {
      //             isLoading = true;
      //           }
      //           if (state is AuthSuccess) {
      //             isLoading = false;
      //             Navigator.pushReplacementNamed(context, signin);
      //           }
      //           if (state is AuthError) {
      //             isLoading = false;
      //             showSnack(context, message: state.message);
      //           }
      //         },
      //       )
      //     ],
      //   ),
    );
  }
}
