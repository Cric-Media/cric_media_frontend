abstract class AppUrl {
  static String developmentUrl = "http://213.199.42.191:3001";
  static String productionUrl = "http://213.199.42.191:3001";

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
