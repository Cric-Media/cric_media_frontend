part of 'admin_cubit.dart';

class AdminState {}

class AdminInitial extends AdminState {}

// Loading states
class AdminLoading extends AdminState {}

class AdminSharePlayerLoading extends AdminState {}

// Success states
class AdminGetOtherAdminsSuccess extends AdminState {
  final ApiResponse response;
  AdminGetOtherAdminsSuccess(this.response);
}

class AdminGetOtherMoreAdminsSuccess extends AdminState {
  final ApiResponse response;
  AdminGetOtherMoreAdminsSuccess(this.response);
}

class AdminSharePlayerSuccess extends AdminState {
  final ApiResponse response;
  AdminSharePlayerSuccess(this.response);
}

// Failute states
class AdminGetOtherAdminsError extends AdminState {
  final String message;
  AdminGetOtherAdminsError(this.message);
}

class AdminSharePlayerError extends AdminState {
  final String message;
  AdminSharePlayerError(this.message);
}
