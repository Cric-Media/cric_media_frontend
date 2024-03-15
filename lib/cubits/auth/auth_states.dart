part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final ApiResponse response;
  AuthSuccess(this.response);
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
