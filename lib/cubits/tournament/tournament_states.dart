part of 'tournament_cubit.dart';

abstract class TournamentState {}

final class TournamentInitial extends TournamentState {}

// Image changed
final class TournamentImageChanged extends TournamentState {}

// Loading
final class TournamentAddLoading extends TournamentState {}

final class TournamentGetInitialLoading extends TournamentState {}

final class TournamentGetMoreLoading extends TournamentState {}

final class TournamentGetLoading extends TournamentState {}

final class TournamentAddTeamLoading extends TournamentState {}

final class TournamentRemoveTeamLoading extends TournamentState {}

final class TournamentUpdateLoading extends TournamentState {}

// Success
final class TournamentAddSuccess extends TournamentState {
  final ApiResponse response;
  TournamentAddSuccess({required this.response});
}

final class TournamentGetInitialSuccess extends TournamentState {
  final ApiResponse response;
  TournamentGetInitialSuccess({required this.response});
}

final class TournamentGetMoreSuccess extends TournamentState {
  final ApiResponse response;
  TournamentGetMoreSuccess({required this.response});
}

final class TournamentGetSuccess extends TournamentState {
  final ApiResponse response;
  TournamentGetSuccess({required this.response});
}

final class TournamentAddTeamSuccess extends TournamentState {
  final ApiResponse response;
  TournamentAddTeamSuccess({required this.response});
}

final class TournamentRemoveTeamSuccess extends TournamentState {
  final ApiResponse response;
  TournamentRemoveTeamSuccess({required this.response});
}

final class TournamentUpdateSuccess extends TournamentState {
  final ApiResponse response;
  TournamentUpdateSuccess({required this.response});
}

// Error
final class TournamentAddError extends TournamentState {
  final String message;
  TournamentAddError({required this.message});
}

final class TournamentGetInitialError extends TournamentState {
  final String message;
  TournamentGetInitialError({required this.message});
}

final class TournamentGetMoreError extends TournamentState {
  final String message;
  TournamentGetMoreError({required this.message});
}

final class TournamentGetError extends TournamentState {
  final String message;
  TournamentGetError({required this.message});
}

final class TournamentAddTeamError extends TournamentState {
  final String message;
  TournamentAddTeamError({required this.message});
}

final class TournamentRemoveTeamError extends TournamentState {
  final String message;
  TournamentRemoveTeamError({required this.message});
}

final class TournamentUpdateError extends TournamentState {
  final String message;
  TournamentUpdateError({required this.message});
}
