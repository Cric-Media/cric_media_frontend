part of 'match_cubit.dart';

abstract class MatchState {}

final class MatchInitial extends MatchState {}

//* Loading states
final class MatchAddDetailsLoading extends MatchState {}

final class MatchUpcommingLoading extends MatchState {}

//* Success states
final class MatchAddDetailsSuccess extends MatchState {
  final ApiResponse res;
  MatchAddDetailsSuccess(this.res);
}

final class MatchUpcommingSuccess extends MatchState {
  final ApiResponse res;
  MatchUpcommingSuccess(this.res);
}

//! Failure states
final class MatchAddDetailsError extends MatchState {
  final String message;
  MatchAddDetailsError(this.message);
}

final class MatchUpcommingError extends MatchState {
  final String message;
  MatchUpcommingError(this.message);
}
