import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class AppUrl {
  static String developmentUrl = dotenv.env['DEVELOPMENT_URL']!;
  static String productionUrl = dotenv.env['PRODUCTION_URL']!;

  static String baseUrl = developmentUrl;
}

abstract class AuthUrl {
  static final sendOtpForSignup = "${AppUrl.baseUrl}/signup";
  static final verifyEmailAndSignup = "${AppUrl.baseUrl}/emailVrifyOtp";
  static final signin = "${AppUrl.baseUrl}/Login";
  static final getUser = "${AppUrl.baseUrl}/get-user-detail";
  static final sendOtpForPasswordChange =
      "${AppUrl.baseUrl}/send-otp-forpassword-change";
  static final verifyOtpForPasswordChange =
      "${AppUrl.baseUrl}/password-otp-varify";
  static final changePassword = "${AppUrl.baseUrl}/changePassword";
}

abstract class AdminUrl {
  static final addPlayer = '${AppUrl.baseUrl}/add-players';
}
