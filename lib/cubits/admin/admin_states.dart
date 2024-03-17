part of 'admin_cubit.dart';

class AdminState {}

class AdminInitial extends AdminState {}

// Loading states
class AdminLoading extends AdminState {}

// Success states
class AdminGetOtherAdminsSuccess extends AdminState {
  final ApiResponse response;
  AdminGetOtherAdminsSuccess(this.response);
}

class AdminGetOtherMoreAdminsSuccess extends AdminState {
  final ApiResponse response;
  AdminGetOtherMoreAdminsSuccess(this.response);
}

// Failute states
class AdminGetOtherAdminsError extends AdminState {
  final String message;
  AdminGetOtherAdminsError(this.message);
}
