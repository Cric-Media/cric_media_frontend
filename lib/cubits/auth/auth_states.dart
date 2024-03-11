part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSignup extends AuthState {
  final ApiResponse response;
  AuthSignup(this.response);
}

class AuthVerifyEmail extends AuthState {
  final ApiResponse response;
  AuthVerifyEmail(this.response);
}

class AuthSignin extends AuthState {
  final ApiResponse response;
  AuthSignin(this.response);
}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}
