part of 'match_cubit.dart';

abstract class MatchState {}

final class MatchInitial extends MatchState {}

//* Loading states
final class MatchAddDetailsLoading extends MatchState {}

final class MatchUpcommingLoading extends MatchState {}

final class MatchLiveLoading extends MatchState {}

final class MatchStartLoading extends MatchState {}

//* Success states
final class MatchAddDetailsSuccess extends MatchState {
  final ApiResponse res;
  MatchAddDetailsSuccess(this.res);
}

final class MatchUpcommingSuccess extends MatchState {
  final ApiResponse res;
  MatchUpcommingSuccess(this.res);
}

final class MatchGetLiveSuccess extends MatchState {
  final ApiResponse res;
  MatchGetLiveSuccess(this.res);
}

final class MatchStartSuccess extends MatchState {
  final ApiResponse res;
  MatchStartSuccess(this.res);
}

//! Failure states
final class MatchAddDetailsError extends MatchState {
  final String message;
  MatchAddDetailsError(this.message);
}

final class MatchGetUpcommingError extends MatchState {
  final String message;
  MatchGetUpcommingError(this.message);
}

final class MatchGetLiveError extends MatchState {
  final String message;
  MatchGetLiveError(this.message);
}

final class MatchStartError extends MatchState {
  final String message;
  MatchStartError(this.message);
}
