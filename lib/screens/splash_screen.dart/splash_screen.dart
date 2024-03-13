// ignore_for_file: prefer_const_constructors, unused_import, unnecessary_null_comparison, use_build_context_synchronously

import 'dart:async';

import 'package:cricket_app/constants/app_images.dart';
import 'package:cricket_app/constants/global.dart';
import 'package:cricket_app/screens/auth_screen/sigin_screen/signIn.dart';
import 'package:cricket_app/screens/dashbord_screen/dashboard_screen.dart';
// ignore: depend_on_referenced_packages
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      navigateBasedOnUserId();
    });
  }

  void navigateBasedOnUserId() async {
    final userId = await Global().getUserId();

    print(' user id  ====.>>>>>${userId}');
    if (userId != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashBoardScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SigninScreen()),
      );
    }
  }

  final icons = AppIcons();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth,
      height: screenHeight,
      decoration: BoxDecoration(),
      child: ExtendedImage.asset(
        'assets/image/splash_screen.webp',
        fit: BoxFit.cover,
        repeat: ImageRepeat.repeat,
      ),
    );
  }
}
