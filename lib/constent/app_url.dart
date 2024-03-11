import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class AppUrl {
  static String developmentUrl = dotenv.env['DEVELOPMENT_URL']!;
  static String productionUrl = dotenv.env['PRODUCTION_URL']!;

  static String baseUrl = developmentUrl;
}

abstract class AuthUrl {
  static final signup = "${AppUrl.baseUrl}/signup";
  static final verifyEmail = "${AppUrl.baseUrl}/verify-email";
  static final signin = "${AppUrl.baseUrl}/signin";
}
