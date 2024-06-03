part of 'news_cubit.dart';

abstract class NewsState {}

final class NewsInitialState extends NewsState {}

//  Loading

final class NewsGetLoadingState extends NewsState {}

final class NewsGetMoreLoadingState extends NewsState {}

// * Success

final class NewsGetSuccessState extends NewsState {
  final ApiResponse response;
  NewsGetSuccessState({required this.response});
}

final class NewsGetMoreSuccessState extends NewsState {
  final ApiResponse response;
  NewsGetMoreSuccessState({required this.response});
}

// ! Error

final class NewsGetErrorState extends NewsState {
  final String error;
  NewsGetErrorState({required this.error});
}
