part of 'player_cubit.dart';

class PlayerState {}

class PlayerInit extends PlayerState {}

class PlayerEmptyState extends PlayerState {}

// Loading states
class PlayerAddLoading extends PlayerState {}

class PlayerGetPlayerLoading extends PlayerState {}

class PlayerGetInitialLoading extends PlayerState {}

class PlayerUpdateLoading extends PlayerState {}

class PlayerDeleteLoading extends PlayerState {}

// Success states
class PlayerAddSuccess extends PlayerState {
  final ApiResponse response;
  PlayerAddSuccess(this.response);
}

class PlayerGetPlayer extends PlayerState {
  final ApiResponse response;
  PlayerGetPlayer(this.response);
}

class PlayerUpdateSuccess extends PlayerState {
  final ApiResponse response;
  PlayerUpdateSuccess(this.response);
}

class PlayerDeleteSuccess extends PlayerState {
  final ApiResponse response;
  PlayerDeleteSuccess(this.response);
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

class PlayerUpdateError extends PlayerState {
  final String message;
  PlayerUpdateError(this.message);
}

class PlayerDeleteError extends PlayerState {
  final String message;
  PlayerDeleteError(this.message);
}

class PlayerGetPlayerError extends PlayerState {
  final String message;
  PlayerGetPlayerError(this.message);
}
