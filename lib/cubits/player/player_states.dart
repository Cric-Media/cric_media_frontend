part of 'player_cubit.dart';

class PlayerState {}

class PlayerInit extends PlayerState {}

class PlayerEmptyState extends PlayerState {}

// Loading states
class PlayerAddLoading extends PlayerState {}

class PlayerGetInitialLoading extends PlayerState {}

// Success states
class PlayerAddSuccess extends PlayerState {
  final ApiResponse response;
  PlayerAddSuccess(this.response);
}

class PlayerGetInitial extends PlayerState {
  final ApiResponse response;
  PlayerGetInitial(this.response);
}

// Error states
class PlayerAddError extends PlayerState {
  final String message;
  PlayerAddError(this.message);
}

class PlayerGetError extends PlayerState {
  final String message;
  PlayerGetError(this.message);
}
