import 'package:cricket_app/screens/auth_screen/sigin_screen/signIn.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/signin':
        return MaterialPageRoute(
          builder: (context) => const SigninScreen(),
        );

      default:
        return null;
    }
  }
}
