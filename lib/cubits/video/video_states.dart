part of 'video_cubit.dart';

abstract class VideoState {}

final class VideoInitial extends VideoState {}

// Loading

final class VideosLoading extends VideoState {}

final class VideosMoreLoading extends VideoState {}

// * Success

final class VideosSuccess extends VideoState {
  final ApiResponse res;
  VideosSuccess(this.res);
}

final class VideosMoreSuccess extends VideoState {
  final ApiResponse res;
  VideosMoreSuccess(this.res);
}

// ! Error

final class VideosError extends VideoState {
  final String message;
  VideosError(this.message);
}
