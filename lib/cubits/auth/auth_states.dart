part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSendOtpLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final ApiResponse response;
  AuthSuccess(this.response);
}

class AuthSendOtpSuccess extends AuthState {
  final ApiResponse response;
  AuthSendOtpSuccess(this.response);
}

class AuthSignin extends AuthState {
  final ApiResponse response;
  AuthSignin(this.response);
}

class AuthGetUser extends AuthState {
  final Admin user;
  AuthGetUser(this.user);
}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}

class AuthSendOtpError extends AuthState {
  final String message;

  AuthSendOtpError(this.message);
}
