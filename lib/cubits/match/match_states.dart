part of 'match_cubit.dart';

abstract class MatchState {}

final class MatchInitial extends MatchState {}

//* Loading states
final class MatchAddDetailsLoading extends MatchState {}

final class MatchUpcommingLoading extends MatchState {}

final class MatchLiveLoading extends MatchState {}

final class MatchStartLoading extends MatchState {}

final class MatchSetOpeningsLoading extends MatchState {}

final class MatchGetLoading extends MatchState {}

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

final class MatchSetOpeningsSuccess extends MatchState {
  final ApiResponse res;
  MatchSetOpeningsSuccess(this.res);
}

final class MatchGetSuccess extends MatchState {
  final ApiResponse res;
  MatchGetSuccess(this.res);
}

final class MatchLiveActionSuccess extends MatchState {
  final ApiResponse res;
  MatchLiveActionSuccess(this.res);
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

final class MatchSetOpeningsError extends MatchState {
  final String message;
  MatchSetOpeningsError(this.message);
}

final class MatchGetError extends MatchState {
  final String message;
  MatchGetError(this.message);
}

final class MatchLiveActionError extends MatchState {
  final String message;
  MatchLiveActionError(this.message);
}
