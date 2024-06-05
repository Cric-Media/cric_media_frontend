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

final class TournamentUpcomingMatchesLoading extends TournamentState {}

final class TournamentLiveMatchesLoading extends TournamentState {}

final class TournamentCompletedMatchesLoading extends TournamentState {}

final class TournamentGetFiveLoading extends TournamentState {}

final class TournamentPointsLoading extends TournamentState {}

final class TournamentGroupToTournamentLoading extends TournamentState {}

final class TournamentTeamsToGroupLoading extends TournamentState {}

final class TournamentRemoveGroupTeamLoading extends TournamentState {}

final class TournamentRemoveGroupLoading extends TournamentState {}

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

final class TournamentUpcomingMatchesSuccess extends TournamentState {
  final ApiResponse response;
  TournamentUpcomingMatchesSuccess({required this.response});
}

final class TournamentLiveMatchesSuccess extends TournamentState {
  final ApiResponse response;
  TournamentLiveMatchesSuccess({required this.response});
}

final class TournamentCompletedMatchesSuccess extends TournamentState {
  final ApiResponse response;
  TournamentCompletedMatchesSuccess({required this.response});
}

final class TournamentGetFiveSuccess extends TournamentState {
  final ApiResponse response;
  TournamentGetFiveSuccess({required this.response});
}

final class TournamentPointsSuccess extends TournamentState {
  final ApiResponse response;
  TournamentPointsSuccess({required this.response});
}

final class TournamentGroupToTournamentSuccess extends TournamentState {
  final ApiResponse response;
  TournamentGroupToTournamentSuccess({required this.response});
}

final class TournamentTeamsToGroupSuccess extends TournamentState {
  final ApiResponse response;
  TournamentTeamsToGroupSuccess({required this.response});
}

final class TournamentRemoveGroupTeamSuccess extends TournamentState {
  final ApiResponse response;
  TournamentRemoveGroupTeamSuccess({required this.response});
}

final class TournamentRemoveGroupSuccess extends TournamentState {
  final ApiResponse response;
  TournamentRemoveGroupSuccess({required this.response});
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

final class TournamentUpcomingMatchesError extends TournamentState {
  final String message;
  TournamentUpcomingMatchesError({required this.message});
}

final class TournamentLiveMatchesError extends TournamentState {
  final String message;
  TournamentLiveMatchesError({required this.message});
}

final class TournamentCompletedMatchesError extends TournamentState {
  final String message;
  TournamentCompletedMatchesError({required this.message});
}

final class TournamentGetFiveError extends TournamentState {
  final String message;
  TournamentGetFiveError({required this.message});
}

final class TournamentPointsError extends TournamentState {
  final String message;
  TournamentPointsError({required this.message});
}

final class TournamentTeamsToGroupError extends TournamentState {
  final String message;
  TournamentTeamsToGroupError({required this.message});
}

final class TournamentGroupToTournamentError extends TournamentState {
  final String message;
  TournamentGroupToTournamentError({required this.message});
}

final class TournamentRemoveGroupTeamError extends TournamentState {
  final String message;
  TournamentRemoveGroupTeamError({required this.message});
}

final class TournamentRemoveGroupError extends TournamentState {
  final String message;
  TournamentRemoveGroupError({required this.message});
}
