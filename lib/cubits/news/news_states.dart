part of 'news_cubit.dart';

abstract class NewsState {}

final class NewsInitialState extends NewsState {}

//  Loading

final class NewsGetLoadingState extends NewsState {}

final class NewsGetMoreLoadingState extends NewsState {}

final class NewsViewLoadingState extends NewsState {}

// * Success

final class NewsGetSuccessState extends NewsState {
  final ApiResponse response;
  NewsGetSuccessState({required this.response});
}

final class NewsGetMoreSuccessState extends NewsState {
  final ApiResponse response;
  NewsGetMoreSuccessState({required this.response});
}

final class NewsViewSuccessState extends NewsState {
  final ApiResponse response;
  NewsViewSuccessState({required this.response});
}

// ! Error

final class NewsGetErrorState extends NewsState {
  final String error;
  NewsGetErrorState({required this.error});
}

final class NewsGetMoreErrorState extends NewsState {
  final String error;
  NewsGetMoreErrorState({required this.error});
}

final class NewsViewErrorState extends NewsState {
  final String error;
  NewsViewErrorState({required this.error});
}
