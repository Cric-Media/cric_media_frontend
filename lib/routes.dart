import 'package:cricket_app/screens/auth_screen/forget_password/change_password_screen.dart';
import 'package:cricket_app/screens/auth_screen/forget_password/verify_email_for_password_screen.dart';
import 'package:cricket_app/screens/auth_screen/sigin_screen/signIn.dart';
import 'package:cricket_app/screens/auth_screen/signUp_screen/signUp_screen.dart';
import 'package:cricket_app/screens/auth_screen/signUp_screen/verify_email_screen.dart';
import 'package:cricket_app/screens/dashbord_screen/dashboard_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => const ChangePasswordScreen(),
        );

      case '/signup':
        return MaterialPageRoute(
          builder: (context) => const SignUpScreen(),
        );

      case '/verify-email':
        return MaterialPageRoute(
          builder: (context) => const VerifyEmailScreen(),
        );

      case '/signin':
        return MaterialPageRoute(
          builder: (context) => const SigninScreen(),
        );

      case '/verify-email-for-password-screen':
        return MaterialPageRoute(
          builder: (context) => const VerifyEmailForPasswordScreen(),
        );

      case '/change-password-screen':
        return MaterialPageRoute(
          builder: (context) => const SigninScreen(),
        );

      case '/dashboard':
        return MaterialPageRoute(
          builder: (context) => const DashBoardScreen(),
        );

      default:
        return null;
    }
  }
}
