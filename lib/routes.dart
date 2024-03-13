import 'package:cricket_app/cubits/auth/auth_cubit.dart';
import 'package:cricket_app/screens/auth_screen/sigin_screen/signIn.dart';
import 'package:cricket_app/screens/auth_screen/signUp_screen/signUp_screen.dart';
import 'package:cricket_app/screens/auth_screen/signUp_screen/verify_email_screen.dart';
import 'package:cricket_app/screens/dashbord_screen/dashboard_screen.dart';
import 'package:cricket_app/screens/splash_screen.dart/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const SplashScreen());

      case '/signup':
        return MaterialPageRoute(
          builder: (context) => BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(),
            child: const SignUpScreen(),
          ),
        );

      case '/verify-email':
        return MaterialPageRoute(
          builder: (context) => BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(),
            child: const VerifyEmailScreen(),
          ),
        );

      case '/signin':
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AuthCubit(),
            child: const SigninScreen(),
          ),
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
