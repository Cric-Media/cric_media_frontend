part of 'tournament_cubit.dart';

abstract class TournamentState {}

final class TournamentInitial extends TournamentState {}

// Image changed
final class TournamentImageChanged extends TournamentState {}

// Loading
final class TournamentAddLoading extends TournamentState {}

final class TournamentGetInitialLoading extends TournamentState {}

// Success
final class TournamentAddSuccess extends TournamentState {
  final ApiResponse response;
  TournamentAddSuccess({required this.response});
}

final class TournamentGetInitialSuccess extends TournamentState {
  final ApiResponse response;
  TournamentGetInitialSuccess({required this.response});
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
