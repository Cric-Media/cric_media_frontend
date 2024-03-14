part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSendOtpForSignup extends AuthState {
  final ApiResponse response;
  AuthSendOtpForSignup(this.response);
}

class AuthVerifyOtpAndSignup extends AuthState {
  final ApiResponse response;
  AuthVerifyOtpAndSignup(this.response);
}

class AuthSignin extends AuthState {
  final ApiResponse response;
  AuthSignin(this.response);
}

class AuthSendOtpForPasswordChange extends AuthState {
  final ApiResponse response;
  AuthSendOtpForPasswordChange(this.response);
}

class AuthVerifyOtpForPassword extends AuthState {
  final ApiResponse response;
  AuthVerifyOtpForPassword(this.response);
}

class AuthChangePassword extends AuthState {
  final ApiResponse response;
  AuthChangePassword(this.response);
}

class AuthGetUser extends AuthState {
  final User user;
  AuthGetUser(this.user);
}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}
