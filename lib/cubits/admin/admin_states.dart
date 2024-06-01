part of 'admin_cubit.dart';

class AdminState {}

class AdminInitial extends AdminState {}

// Loading states
class AdminLoading extends AdminState {}

class AdminDetailsLoading extends AdminState {}

class AdminSharePlayerLoading extends AdminState {}

class AdminShareTeamLoading extends AdminState {}

class AdminInvitationsLoading extends AdminState {}

class AdminInvitationResponseLoading extends AdminState {}

class AdminShareLoading extends AdminState {}

// Success states

class AdminDetailsSuccess extends AdminState {
  final ApiResponse response;
  AdminDetailsSuccess(this.response);
}

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

class AdminShareTeamSuccess extends AdminState {
  final ApiResponse response;
  AdminShareTeamSuccess(this.response);
}

class AdminInvitationsSuccess extends AdminState {
  final ApiResponse response;
  AdminInvitationsSuccess(this.response);
}

class AdminInvitationResponseSuccess extends AdminState {
  final ApiResponse response;
  AdminInvitationResponseSuccess(this.response);
}

class AdminShareSuccess extends AdminState {
  final ApiResponse response;
  AdminShareSuccess(this.response);
}

// ! Failute states

class AdminDetailsError extends AdminState {
  final String message;
  AdminDetailsError(this.message);
}

class AdminGetOtherAdminsError extends AdminState {
  final String message;
  AdminGetOtherAdminsError(this.message);
}

class AdminSharePlayerError extends AdminState {
  final String message;
  AdminSharePlayerError(this.message);
}

class AdminShareTeamError extends AdminState {
  final String message;
  AdminShareTeamError(this.message);
}

class AdminInvitationsError extends AdminState {
  final String message;
  AdminInvitationsError(this.message);
}

class AdminInvitationResponseError extends AdminState {
  final String message;
  AdminInvitationResponseError(this.message);
}

class AdminShareError extends AdminState {
  final String message;
  AdminShareError(this.message);
}
