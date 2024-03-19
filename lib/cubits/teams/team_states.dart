part of 'team_cubit.dart';

class TeamState {}

class TeamInit extends TeamState {}

class TeamEmptyState extends TeamState {}

// Loading states
class TeamAddLoading extends TeamState {}

class TeamGetTeamLoading extends TeamState {}

class TeamGetInitialLoading extends TeamState {}

class TeamUpdateLoading extends TeamState {}

class TeamDeleteLoading extends TeamState {}

// Success states
class TeamAddSuccess extends TeamState {
  final ApiResponse response;
  TeamAddSuccess(this.response);
}

class TeamGetTeam extends TeamState {
  final ApiResponse response;
  TeamGetTeam(this.response);
}

class TeamUpdateSuccess extends TeamState {
  final ApiResponse response;
  TeamUpdateSuccess(this.response);
}

class TeamDeleteSuccess extends TeamState {
  final ApiResponse response;
  TeamDeleteSuccess(this.response);
}

class TeamGetInitial extends TeamState {
  final ApiResponse response;
  TeamGetInitial(this.response);
}

// Error states
class TeamAddError extends TeamState {
  final String message;
  TeamAddError(this.message);
}

class TeamGetError extends TeamState {
  final String message;
  TeamGetError(this.message);
}

class TeamUpdateError extends TeamState {
  final String message;
  TeamUpdateError(this.message);
}

class TeamDeleteError extends TeamState {
  final String message;
  TeamDeleteError(this.message);
}

class TeamGetTeamError extends TeamState {
  final String message;
  TeamGetTeamError(this.message);
}
