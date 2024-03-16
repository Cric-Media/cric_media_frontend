part of 'player_cubit.dart';

class PlayerState {}

class PlayerInit extends PlayerState {}

class PlayerLoading extends PlayerState {}

// Success states
class PlayerAddSuccess extends PlayerState {
  final ApiResponse response;
  PlayerAddSuccess(this.response);
}

// Error states
class PlayerAddError extends PlayerState {
  final String message;
  PlayerAddError(this.message);
}
