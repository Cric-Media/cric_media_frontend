abstract class AppUrl {
  static String developmentUrl = "http://213.199.42.191:3001";
  static String productionUrl = "http://213.199.42.191:3001";

  static String baseUrl = developmentUrl;
}

abstract class AuthUrl {
  static final signup = "${AppUrl.baseUrl}/signup";
  static final verifyEmail = "${AppUrl.baseUrl}/emailVrifyOtp";
  static final signin = "${AppUrl.baseUrl}/Login";
}
