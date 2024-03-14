import 'package:cricket_app/constants/routes_names.dart';
import 'package:cricket_app/cubits/auth/auth_cubit.dart';
import 'package:cricket_app/screens/auth_screen/forget_password/change_password_screen.dart';
import 'package:cricket_app/screens/auth_screen/forget_password/forget_password.dart';
import 'package:cricket_app/screens/auth_screen/forget_password/verify_email_for_password_screen.dart';
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
      case index:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AuthCubit(),
            child: const SplashScreen(),
          ),
        );

      case signup:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AuthCubit(),
            child: const SignUpScreen(),
          ),
        );

      case verifyEmail:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AuthCubit(),
            child: const VerifyEmailScreen(),
          ),
        );

      case signin:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AuthCubit(),
            child: const SigninScreen(),
          ),
        );

      case forgetPassword:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AuthCubit(),
            child: const ForgetPassword(),
          ),
        );

      case verifyEmailForPassword:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AuthCubit(),
            child: const VerifyEmailForPasswordScreen(),
          ),
        );

      case changePassword:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AuthCubit(),
            child: const ChangePasswordScreen(),
          ),
        );

      case dashboard:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AuthCubit(),
            child: const DashBoardScreen(),
          ),
        );

      default:
        return null;
    }
  }
}
