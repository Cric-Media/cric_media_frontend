part of 'social_link_cubit.dart';

abstract class SocialLinkState {}

final class SocialLinkInitial extends SocialLinkState {}

// Loading ***

final class SocialLinkGetLoading extends SocialLinkState {}

// * Success ***

final class SocialLinkGetSuccess extends SocialLinkState {
  final ApiResponse res;
  SocialLinkGetSuccess(this.res);
}

// ! Error ***

final class SocialLinkGetError extends SocialLinkState {
  final String message;
  SocialLinkGetError(this.message);
}
