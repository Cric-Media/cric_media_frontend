part of 'video_cubit.dart';

abstract class VideoState {}

final class VideoInitial extends VideoState {}

// Loading

final class VideosLoading extends VideoState {}

final class VideosMoreLoading extends VideoState {}

final class VideoViewLoading extends VideoState {}

// * Success

final class VideosSuccess extends VideoState {
  final ApiResponse res;
  VideosSuccess(this.res);
}

final class VideosMoreSuccess extends VideoState {
  final ApiResponse res;
  VideosMoreSuccess(this.res);
}

final class VideoViewSuccess extends VideoState {
  final ApiResponse res;
  VideoViewSuccess(this.res);
}

// ! Error

final class VideosError extends VideoState {
  final String message;
  VideosError(this.message);
}

final class VideosMoreError extends VideoState {
  final String message;
  VideosMoreError(this.message);
}

final class VideoViewError extends VideoState {
  final String message;
  VideoViewError(this.message);
}
