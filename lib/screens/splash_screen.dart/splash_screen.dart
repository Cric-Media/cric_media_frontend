// ignore_for_file: use_build_context_synchronously

import 'package:cricket_app/constants/app_images.dart';
import 'package:cricket_app/constants/global.dart';
import 'package:cricket_app/constants/routes_names.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   navigateBasedOnUserId();
    // });
    Future.delayed(const Duration(seconds: 3), () {
      navigateBasedOnUserId();
    });
  }

  void navigateBasedOnUserId() async {
    final userId = await Global().getAdminId();
    final token = await Global().getToken();

    if (userId != null && token != null) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(dashboard, (route) => false);
    } else {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(dashboard, (route) => false);
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
      decoration: const BoxDecoration(),
      child: ExtendedImage.asset(
        'assets/image/splash.png',
        fit: BoxFit.cover,
        repeat: ImageRepeat.repeat,
      ),
    );
  }
}
