part of 'match_cubit.dart';

abstract class MatchState {}

final class MatchInitial extends MatchState {}

//* Loading states
final class MatchAddDetailsLoading extends MatchState {}

final class MatchUpcommingLoading extends MatchState {}

final class MatchGetCompletedLoading extends MatchState {}

final class MatchLiveLoading extends MatchState {}

final class MatchStartLoading extends MatchState {}

final class MatchSetOpeningsLoading extends MatchState {}

final class MatchGetLoading extends MatchState {}

final class MatchLiveActionLoading extends MatchState {}

final class MatchScoreCardsLoading extends MatchState {}

final class MatchGetInitialOversLoading extends MatchState {}

final class MatchGetMoreOversLoading extends MatchState {}

final class MatchSetManOfTheMatchLoading extends MatchState {}

final class MatchStartStopLoading extends MatchState {}

final class MatchBannerLiveLoading extends MatchState {}

final class MatchBannerUpcomingLoading extends MatchState {}

//* Success states
final class MatchAddDetailsSuccess extends MatchState {
  final ApiResponse res;
  MatchAddDetailsSuccess(this.res);
}

final class MatchUpcommingSuccess extends MatchState {
  final ApiResponse res;
  MatchUpcommingSuccess(this.res);
}

final class MatchGetCompletedSuccess extends MatchState {
  final ApiResponse res;
  MatchGetCompletedSuccess(this.res);
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

final class MatchGetForInningSuccess extends MatchState {
  final ApiResponse res;
  MatchGetForInningSuccess(this.res);
}

final class MatchLiveActionSuccess extends MatchState {
  final ApiResponse res;
  MatchLiveActionSuccess(this.res);
}

final class MatchScoreCardsSuccess extends MatchState {
  final ApiResponse res;
  MatchScoreCardsSuccess(this.res);
}

final class MatchGetInitialOversSuccess extends MatchState {
  final ApiResponse res;
  MatchGetInitialOversSuccess(this.res);
}

final class MatchGetMoreOversSuccess extends MatchState {
  final ApiResponse res;
  MatchGetMoreOversSuccess(this.res);
}

final class MatchSetManOfTheMatchSuccess extends MatchState {
  final ApiResponse res;
  MatchSetManOfTheMatchSuccess(this.res);
}

final class MatchStartStopSuccess extends MatchState {
  final ApiResponse res;
  MatchStartStopSuccess(this.res);
}

final class MatchBannerLiveSuccess extends MatchState {
  final ApiResponse res;
  MatchBannerLiveSuccess(this.res);
}

final class MatchBannerUpcomingSuccess extends MatchState {
  final ApiResponse res;
  MatchBannerUpcomingSuccess(this.res);
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

final class MatchGetCompletedError extends MatchState {
  final String message;
  MatchGetCompletedError(this.message);
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

final class MatchGetForInningError extends MatchState {
  final String message;
  MatchGetForInningError(this.message);
}

final class MatchLiveActionError extends MatchState {
  final String message;
  MatchLiveActionError(this.message);
}

final class MatchScoreCardsError extends MatchState {
  final String message;
  MatchScoreCardsError(this.message);
}

final class MatchGetInitialOversError extends MatchState {
  final String message;
  MatchGetInitialOversError(this.message);
}

final class MatchGetMoreOversError extends MatchState {
  final String message;
  MatchGetMoreOversError(this.message);
}

final class MatchSetManOfTheMatchError extends MatchState {
  final String message;
  MatchSetManOfTheMatchError(this.message);
}

final class MatchStartStopError extends MatchState {
  final String message;
  MatchStartStopError(this.message);
}

final class MatchBannerError extends MatchState {
  final String message;
  MatchBannerError(this.message);
}
